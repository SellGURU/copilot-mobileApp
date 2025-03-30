import 'package:bloc/bloc.dart';
import 'package:copilet/screens/chatScreen/cubit/state.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';

/// The ChatCubit class handles the state and logic for managing the chat functionality
/// within the application, including sending and retrieving messages.

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    // getHistoryChat();  // Initialize the chat history when the cubit is created
  }

  // List of messages in the current chat session
  List<Message> messages = [];

  // Dio instance for making network requests
  Dio _dio = Dio();

  // Conversation ID for tracking chat sessions
  var conversationId = 1;

  /// Sends a new message from the user to the chat API and updates the chat state.
  ///
  /// [message] is the text message to be sent, and [base64] is an optional image encoded in base64.
  Future<void> sendMessage(String message, String base64) async {
    final now = DateTime.now();

    // Immediately add the user's message to the list
    messages.add(Message(
        sender: 'User',
        text: message,
        time: "${now.hour}:${now.minute}",
        avatarUrl: 'assets/avatar12.svg',
        message_to:'ai',
        images: base64.isNotEmpty ? [base64] : []));

    // Emit updated message list to update the UI
    emit(ChatHistoryLoaded(List.from(messages)));

    var token = await getTokenLocally();  // Retrieve token locally
    _dio.options.headers['Authorization'] = "Bearer $token";  // Set authorization header

    try {
      // Send message to the server
      final response = await _dio.post(
        Endpoints.mobile_chat,
        data: {
          "text": message,
          "conversation_id": conversationId,
          "images": [],
          "message_to":"ai"
        },
      );

      if (response.statusCode == 200) {
        // Add the AI's response to the list if the request is successful
        conversationId = response.data["current_conversation_id"];
        messages.add(Message.fromResponse({
          'entrytime': ": ${now.hour}:${now.minute}",
          'response': response.data["answer"]
        }));

        emit(ChatHistoryLoaded(List.from(messages)));  // Emit the updated messages
      } else {
        // Handle error if status code is not 200
        emit(ChatError("Failed to send message"));
        emit(ChatHistoryLoaded(List.from(messages)));
      }
    } catch (e) {
      // Catch and handle any errors during the message sending process
      emit(ChatError("An error occurred: $e"));
      emit(ChatHistoryLoaded(List.from(messages)));
    }
  }

  /// Fetches the chat history from the server and updates the chat state.
  Future<void> getHistoryChat() async {
    emit(ChatHistoryLoading());  // Emit loading state

    var token = await getTokenLocally();  // Retrieve token locally
    _dio.options.headers['Authorization'] = "bearer $token";  // Set authorization header

    try {
      // Request chat history from the server
      final response = await _dio.post(Endpoints.getHistoryChat);

      if (response.statusCode == 200) {
        if (response.data["conversation_id"] != null) {
          conversationId = response.data["conversation_id"];  // Update conversation ID if available
        }

        if (response.data["messages"].isNotEmpty) {
          // Add the messages to the list
          for (var entry in response.data["messages"]) {
            String time = entry["entrytime"] ?? "";

            if (entry["request"] != null && entry["request"].isNotEmpty) {
              messages.add(Message.fromRequest(entry));
            }

            if (entry["response"] != null && entry["response"].isNotEmpty) {
              messages.add(Message.fromResponse(entry));
            }
          }

          emit(ChatHistoryLoaded(List.from(messages)));  // Emit the updated messages
        } else {
          emit(ChatHistoryError("No messages found"));
          // Emit previous messages if any exist
          if (messages.isNotEmpty) {
            emit(ChatHistoryLoaded(List.from(messages)));
          }
        }
      } else {
        emit(ChatHistoryError("Failed to load history"));
        if (messages.isNotEmpty) {
          emit(ChatHistoryLoaded(List.from(messages)));
        }
      }
    } catch (e) {
      // Catch and handle any errors during fetching history
      emit(ChatHistoryError("An error occurred: $e"));
      if (messages.isNotEmpty) {
        emit(ChatHistoryLoaded(List.from(messages)));  // Emit the previous messages in case of error
      }
    }
  }
}
