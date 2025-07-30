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
    // First check if user should be forced to logout
    // bool shouldForceLogoutUser = await shouldForceLogout();
    // if (shouldForceLogoutUser) {
    //   // await clearToken();
    //   emit(LoggedOutState());
    //   return;
    // }
    
    var token = await getTokenLocally();
    if (token == null || token.isEmpty) {
      emit(LoggedOutState());
    } else {
      _dio.options.headers['Authorization'] = "bearer $token";

      _dio.post(Endpoints.clientInformationMobile).then((value) async {
        if (value.data["detail"] == "Not authenticated" ||value.data["detail"] == "Expired token."||value.data["detail"] ==  "Invalid token.") {
          // Clear invalid token and emit logged out state
          // await clearToken();
          emit(LoggedOutState());
        } else {
          var token = await getTokenLocally();
          // print("token1:${token}");
          // print(token!.isNotEmpty);
          if (token != null && token.isNotEmpty) {
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
        // print("value.toString():" + value.toString());
        if (value.statusCode == 200 && value.data["detail"] == null) {
          // print("token11 $value");
          await UpdateToken(value.data["access_token"]);
          await UpdateEncode(value.data["encoded_mi"]);
          emit(SuccessState());
        } else {
          // print("else");
          // emit(SuccessState());
          emit(ErrorState(value.data["detail"]));
        }
      });
    } catch (e) {
      print("catch: $e");
      // emit(SuccessState());
      emit(ErrorState("The email or password is incorrect."));
    }
  }

  logOut() async {
    // Clear all stored data including tokens, user info, and credentials
    // await clearToken();
    await UpdateToken("");
    emit(LoggedOutState());
  }

  // Method to clear all data and reset everything
  // clearAllData() async {
  //   // Import the comprehensive logout function
  //   // await clearAllDataAndReset();
  //   emit(LoggedOutState());
  // }
}
