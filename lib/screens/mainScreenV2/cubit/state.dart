class HealthScoreState {
  HealthScoreState init() {
    return HealthScoreState();
  }

  HealthScoreState clone() {
    return HealthScoreState();
  }

  getScoreHealthData() {}
}

final class BiomarkerInit extends HealthScoreState {}

final class LoadingHealthScore extends HealthScoreState {}

final class ErrorHealthScore extends HealthScoreState {}

final class SuccessHealthScore extends HealthScoreState {
  final Map<String, dynamic> scoreData;
  SuccessHealthScore({required this.scoreData});
}

//{"Physiological":0,"Fitness":0,"Emotional":0}