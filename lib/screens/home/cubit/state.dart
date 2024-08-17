class BiomarkerState {
  BiomarkerState init() {
    return BiomarkerState();
  }

  BiomarkerState clone() {
    return BiomarkerState();
  }

  getBiomarkerData() {}
}

final class BiomarkerInit extends BiomarkerState {}

final class LoadingBiomarkerState extends BiomarkerState {}

final class ErrorBiomarkerState extends BiomarkerState {}

final class SuccessBiomarkerState extends BiomarkerState {
  var biomarkerData = {};
  SuccessBiomarkerState({required this.biomarkerData});
  @override
  getBiomarkerData() {
    return this.biomarkerData;
  }
}
