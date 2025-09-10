import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import '../../../utility/token/updateToken.dart';
import 'dart:convert';

class AuthorizersRookCubit extends Cubit<AuthorizersRookState> {
  AuthorizersRookCubit() : super(AuthorizersRookState()) {
    _initialize();
  }
  Future<void> _initialize() async {
    getDataRook();
  }

  final Dio _dio = Dio();

  Future<void> getDataRook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    String url="https://api.rook-connect.com/api/v1/client_uuid/c2f4961b-9d3c-4ff0-915e-f70655892b89/user_id/${email}/data_sources/authorizers";
    // print("check rook");
    emit(LoadingAuthorizersRookState());
    // var token = await getTokenLocally();
    _dio.options.headers['Authorization'] ="Basic Y2xpZW50X3V1aWQ6UUg4dTE4T2pMb2ZzU1J2bUVEbUdCZ2p2MWZycDNmYXBkYkRB";

    try {
      _dio.get(url).then((res) {
        if(res.data!=null){
          emit(SuccessAuthorizersRookState(data: res.data["data_sources"]));
          // print("rook res.data:${res.data["data_sources"]}");
        }
        else{
          print("rook be null");
          emit(ErrorAuthorizersRookState(""));
        }
      });
    } catch (e) {
      print("error download data rook $e");
      emit(ErrorAuthorizersRookState(""));
    }
  }
}
