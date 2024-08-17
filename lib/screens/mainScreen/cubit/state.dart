class BiomarkerState {
  BiomarkerState init() {
    return BiomarkerState();
  }

  BiomarkerState clone() {
    return BiomarkerState();
  }
}


final class BiomarkerInit extends BiomarkerState{}
final class LoadingState extends BiomarkerState{}
final class ErrorState extends BiomarkerState{}
final class SuccessState extends BiomarkerState{}
final class LoggedInState extends BiomarkerState{}


