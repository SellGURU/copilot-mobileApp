import 'package:bloc/bloc.dart';
import 'package:copilet/screens/chatScreen/cubit/state.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<Message> messages = [];
  Dio _dio = Dio();
  var conversationId=1;

  Future<void> sendMessage(String message) async {
    emit(ChatLoading());
    messages.add(Message(sender: 'User', content: message));
    var token = await getTokenLocally();

    try {
      _dio.options.headers['Authorization'] = "bearer $token";
      _dio.post(Endpoints.mobile_chat,data: {
        {
          "text": message,
          "conversation_id":conversationId
        }
      }).then((response) {
        if (response.statusCode == 200) {
          messages.add(Message(sender: 'Ai', content: response.data["answer"]));
          emit(ChatLoaded(List.from(messages)));
        } else {
          emit(ChatError("Failed to send message"));
        }
      });
    } catch (e) {
      emit(ChatError("An error occurred: $e"));
    }
  }

  Future<void> getHistoryChat(String message) async {
    emit(ChatHistoryLoading());

    try {
      _dio.post(Endpoints.getHistoryChat).then((response) {
        if (response.statusCode == 200) {
          if(response.data["conversation_id"]!=null){
            conversationId=response.data["conversation_id"];
          }
          messages.add(Message(sender: 'Ai', content: response.data["answer"]));
          emit(ChatHistoryLoaded(response.data["messages"]));
        } else {
          emit(ChatHistoryError("Failed to load history message"));
        }
      });
    } catch (e) {
      emit(ChatHistoryError("An error occurred: $e"));
    }
  }
}
