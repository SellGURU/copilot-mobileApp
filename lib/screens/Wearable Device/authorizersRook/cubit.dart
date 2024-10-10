import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import '../../../utility/token/updateToken.dart';


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
    String url="https://api.rook-connect.review/api/v1/client_uuid/b0eb1473-44ed-4c93-8d90-eb15deb20bb7/user_id/${email}/data_sources/authorizers";
    print("check rook");
    emit(LoadingAuthorizersRookState());
    // var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "Basic YjBlYjE0NzMtNDRlZC00YzkzLThkOTAtZWIxNWRlYjIwYmI3OkZGeWJpM2VaZWZZVjhaTWhMT2VBdVQ4NzI0b08zeWJNa2dkUg==";

    try {
      _dio.get(url).then((res) {
        if(res.data!=null){
          emit(SuccessAuthorizersRookState(data: res.data["data_sources"]));
          print("rook res.data:${res.data["data_sources"]}");
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
