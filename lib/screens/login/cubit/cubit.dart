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
  Dio _dio = Dio();

  Future<void> _initialize() async {
    var token = await getTokenLocally();
    if (token == null) {
      emit(logOut());
    } else {
      _dio.options.headers['Authorization'] = "bearer $token";

      _dio.post(Endpoints.clientInformationMobile).then((value) async {
        if (value.data["detail"] == "Not authenticated" ||value.data["detail"] == "Expired token."||value.data["detail"] ==  "Invalid token.") {
          emit(LoggedOutState());
        } else {
          var token = await getTokenLocally();
          print("token1:${token}");
          print(token!.isNotEmpty);
          if (token!.isNotEmpty) {
            emit(LoggedInState());
          } else {
            emit(LoggedOutState());
          }
        }
      }).catchError((_) {
        // print("check the error");
        emit(LoggedOutState());
      });
    }
  }

  logIn(email, pass) async {
    emit(LoadingState());
    // _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    try {
      await _dio.post(
        Endpoints.login,
        data: {"email": email, "password": pass},
      ).then((value) async {
        print("value.toString():" + value.toString());
        if (value.statusCode == 200 && value.data["detail"] == null) {
          print("token11 $value");
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
