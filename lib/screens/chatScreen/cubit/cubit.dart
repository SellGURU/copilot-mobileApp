import 'package:bloc/bloc.dart';
import 'package:copilet/screens/chatScreen/cubit/state.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()) {
    getHistoryChat();
  }

  List<Message> messages = [];
  Dio _dio = Dio();
  var conversationId = 1;

  Future<void> sendMessage(String message, String base64) async {
    final now = DateTime.now();

    // Add the user's message to the list immediately
    messages.add(Message(
        sender: 'User',
        text: message,
        time: "${now.hour}:${now.minute}",
        avatarUrl: 'assets/avatar12.svg',
        images: base64.isNotEmpty ? [base64] : []));

    // Emit updated message list to update the UI
    emit(ChatHistoryLoaded(List.from(messages)));
    print(base64);
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "Bearer $token";

    try {
      final response = await _dio.post(
        Endpoints.mobile_chat,
        data: {
          "text": message,
          "conversation_id": conversationId,
          "images": base64.isNotEmpty ? [base64] : []
        },
      );

      if (response.statusCode == 200) {
        // Add the AI's response to the list
        // print("response.data:${response.data}");

        conversationId = response.data["current_conversation_id"];
        messages.add(Message.fromResponse({
          'entrytime': ": ${now.hour}:${now.minute}",
          'response': response.data["answer"]
        }));

        // print("chech1 ${messages[messages.length-1].text}");

        emit(ChatHistoryLoaded(List.from(messages)));
      } else {
        emit(ChatError("Failed to send message"));
        print("chech2");
        // Emit the messages even during an error
        emit(ChatHistoryLoaded(List.from(messages)));
      }
    } catch (e) {
      print("chech3 $e");
      emit(ChatError("An error occurred: $e"));
      // Emit the messages even during an error
      emit(ChatHistoryLoaded(List.from(messages)));
    }
  }

  Future<void> getHistoryChat() async {
    emit(ChatHistoryLoading());
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";

    try {
      final response = await _dio.post(Endpoints.getHistoryChat);

      if (response.statusCode == 200) {
        if (response.data["conversation_id"] != null) {
          conversationId = response.data["conversation_id"];
        }

        if (response.data["messages"].isNotEmpty) {
          for (var entry in response.data["messages"]) {
            String time = entry["entrytime"] ?? "";

            if (entry["request"] != null && entry["request"].isNotEmpty) {
              messages.add(Message.fromRequest(entry));
            }

            if (entry["response"] != null && entry["response"].isNotEmpty) {
              messages.add(Message.fromResponse(entry));
            }
          }

          emit(ChatHistoryLoaded(List.from(messages)));
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
      emit(ChatHistoryError("An error occurred: $e"));
      if (messages.isNotEmpty) {
        emit(ChatHistoryLoaded(List.from(messages)));
      }
    }
  }
}
