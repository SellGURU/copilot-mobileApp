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

  logIn(email,pass) async {
    emit(LoadingState());
    // _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    try {
      await _dio.post(
        Endpoints.login,
        data: {
          "email":email
        },
      ).then((value) async {
        print("value.toString():"+value.toString());
        if (value.statusCode == 200&&value.data["detail"]==null) {
          print("token $value");
          await UpdateToken(value.data["access_token"]);
          emit(SuccessState());
        } else {
          print("else");
          // emit(SuccessState());
          emit(ErrorState(value.data["detail"]));
        }
      });
    } catch (e) {
      print("catch: $e");
      // emit(SuccessState());
      emit(ErrorState("server error"));
    }
  }
  logOut() async {
    await UpdateToken("");
    emit(LoggedOutState());
  }

}
