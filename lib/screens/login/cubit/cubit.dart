
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import '../../../utility/token/updateToken.dart';
import 'state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState()) {
    _initialize();
  }
  Future<void> _initialize() async {
    var token = await getTokenLocally();
    print("token1:${token}");
    print(token!.isNotEmpty);
    if (token!.isNotEmpty) {
      emit(LoggedInState());
    } else {
      emit(LoggedOutState());
    }
  }

  Dio _dio = Dio();

  logIn(username, password) async {
    emit(LoadingState());
    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    try {
      await _dio.post(
        Endpoints.login,
        data: {
          'grant_type': '',
          'username': username,
          'password': password,
          'scope': '',
          'client_id': '',
          'client_secret': ''
        },
      ).then((value) async {
        // print(value.toString());
        if (value.statusCode == 200) {
          await UpdateToken("token");
          emit(SuccessState());
        } else {
          print("else");
          emit(SuccessState());

          // emit(ErrorState());
        }
      });
    } catch (e) {
      print(e);
      emit(SuccessState());
      // emit(ErrorState());
    }
  }
}