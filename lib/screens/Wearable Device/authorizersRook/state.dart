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
  var data ;
  SuccessAuthorizersRookState({required this.data});
}

