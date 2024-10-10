import 'package:bloc/bloc.dart';

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

  }

  final Dio _dio = Dio();

  Future<void> getPdf() async {
    const String url="https://api.rook-connect.review/api/v1/client_uuid/b0eb1473-44ed-4c93-8d90-eb15deb20bb7/user_id/amir12@gmail.com/data_sources/authorizers";
    print("check rook");
    emit(LoadingAuthorizersRookState());
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";

    try {
      _dio.post(url).then((res) {
        if(res.data!=null){
          emit(SuccessAuthorizersRookState(data: res.data));
          print("rook res.data:${res.data}");
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
