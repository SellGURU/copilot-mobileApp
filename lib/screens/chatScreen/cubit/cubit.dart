import 'package:bloc/bloc.dart';
import 'package:copilet/screens/chatScreen/cubit/state.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()){
    getHistoryChat();
  }

  List<Message> messages = [];
  Dio _dio = Dio();
  var conversationId=1;

  Future<void> sendMessage(String message) async {
    // Add the user's message to the list immediately
    messages.add(Message(
      sender: 'User',
      text: message,
      time: DateTime.now().toString(), // Set the current time for user message
      avatarUrl: 'path/to/user/avatar', // Replace with the actual user avatar path
    ));

    // Emit updated message list to update the UI
    emit(ChatHistoryLoaded(List.from(messages)));

    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "Bearer $token";

    try {
      // Send the user's message to the server
      final response = await _dio.post(
        Endpoints.mobile_chat,
        data: {
          "text": message,
          "conversation_id": conversationId,
        },
      );

      if (response.statusCode == 200) {
        // Add the AI's response to the list
        messages.add(Message(
          sender: 'Ai',
          text: response.data["answer"],
          time: DateTime.now().toString(), // Set the current time for AI response
          avatarUrl: 'path/to/ai/avatar', // Replace with the actual AI avatar path
        ));

        // Emit the updated message list to update the UI again
        emit(ChatHistoryLoaded(List.from(messages)));
      } else {
        emit(ChatError("Failed to send message"));
      }
    } catch (e) {
      emit(ChatError("An error occurred: $e"));
    }
  }

  Future<void> getHistoryChat() async {
    emit(ChatHistoryLoading());
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";

    try {
      _dio.post(Endpoints.getHistoryChat).then((response) {
        if (response.statusCode == 200) {
          print("data test bb ${response.data}");

          if(response.data["conversation_id"]!=null){
            conversationId=response.data["conversation_id"];
          }

          if(response.data["messages"].length>0) {

            for (var entry in response.data["messages"]) {
              String time = entry["entrytime"] ?? ""; // Get message time
              // Create Message for user's request
              if (entry["request"] != null && entry["request"].isNotEmpty) {
                messages.add(Message.fromRequest(time, entry["request"]));
              }


              // Create Message for system's response
              if (entry["response"] != null && entry["response"].isNotEmpty) {
                messages.add(Message.fromResponse(time, entry["response"]));
              }

              emit(ChatHistoryLoaded(messages));
            }
          }
          else {
            emit(ChatHistoryLoaded(response.data["messages"] ?? []));
            emit(ChatHistoryError("Failed to load history message"));
          }
        }
      });
    } catch (e) {
      emit(ChatHistoryError("An error occurred: $e"));
    }
  }
}
