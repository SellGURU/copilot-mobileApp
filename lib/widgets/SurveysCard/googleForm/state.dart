class GoogleFormState {
  GoogleFormState init() {
    return GoogleFormState();
  }
}

final class GoogleFormStateInit extends GoogleFormState {}

final class LoadingGoogleFormState extends GoogleFormState {}

final class ErrorGoogleFormState extends GoogleFormState {}

final class SuccessGoogleFormState extends GoogleFormState {
  final Map googleFormData;
  SuccessGoogleFormState({required this.googleFormData});
}

//{"Physiological":0,"Fitness":0,"Emotional":0}