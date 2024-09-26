class ClientInformationMobileState {
  ClientInformationMobileState init() {
    return ClientInformationMobileState();
  }

  ClientInformationMobileState clone() {
    return ClientInformationMobileState();
  }

}

final class ClientInformationMobileStateInit extends ClientInformationMobileState {}

final class LoadingClientInformationMobileState extends ClientInformationMobileState {}

final class ErrorClientInformationMobileState extends ClientInformationMobileState {}

final class SuccessClientInformation extends ClientInformationMobileState {
  final Map<String, dynamic> userInfo;
  SuccessClientInformation({required this.userInfo});
}

//{"Physiological":0,"Fitness":0,"Emotional":0}