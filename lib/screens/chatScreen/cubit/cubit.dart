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
    emit(ChatLoading());
    messages.add(Message(sender: 'User',  time: '', avatarUrl: '',text: message,));
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";

    try {
      _dio.post(Endpoints.mobile_chat,data:
        {
          "text": message,
          "conversation_id":conversationId
        }
      ).then((response) {
        if (response.statusCode == 200) {
          messages.add(Message(sender: 'Ai',  time: '', avatarUrl: '',text: response.data["answer"]));
          emit(ChatHistoryLoaded(messages));
        } else {
          emit(ChatError("Failed to send message"));
        }
      });
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
          if(response.data["conversation_id"]==null){
            print("check hi null");
            conversationId=response.data["conversation_id"];
          }

          print("check hi 1");

          if(response.data["messages"].length>0) {
            print("check hi 2");

            for (var entry in response.data["messages"]) {
              String time = entry["entrytime"] ?? ""; // Get message time

              // Create Message for user's request
              if (entry["request"] != null && entry["request"].isNotEmpty) {
                messages.add(Message.fromRequest(time, entry["request"]));
              }

              print("check hi 3");

              // Create Message for system's response
              if (entry["response"] != null && entry["response"].isNotEmpty) {
                messages.add(Message.fromResponse(time, entry["response"]));
              }

              emit(ChatHistoryLoaded(messages));
              print("ChatHistoryLoaded finish");
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
