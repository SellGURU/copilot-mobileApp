class AuthState {
  AuthState init() {
    return AuthState();
  }

  AuthState clone() {
    return AuthState();
  }
}


final class LoadingState extends AuthState{}
final class ErrorState extends AuthState{}
final class SuccessState extends AuthState{}
final class LoggedInState extends AuthState{}
final class LoggedOutState extends AuthState{}


