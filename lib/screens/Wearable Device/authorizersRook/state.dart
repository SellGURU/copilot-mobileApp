class AuthorizersRookState {
  AuthorizersRookState init() {
    return AuthorizersRookState();
  }
}
final class LoadingAuthorizersRookState extends AuthorizersRookState{}
final class ErrorAuthorizersRookState extends AuthorizersRookState{
  var errorText="";
  ErrorAuthorizersRookState(this.errorText);
}
final class SuccessAuthorizersRookState extends AuthorizersRookState{
  final String data ;
  SuccessAuthorizersRookState({required this.data});
}

