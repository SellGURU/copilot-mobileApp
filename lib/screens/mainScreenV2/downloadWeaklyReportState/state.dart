// class DownloadWeaklyReportState {
//   DownloadWeaklyReportState init() {
//     return DownloadWeaklyReportState();
//   }
//
//   DownloadWeaklyReportState clone() {
//     return DownloadWeaklyReportState();
//   }
// }
class DownloadWeaklyReportState {
  DownloadWeaklyReportState init() {
    return DownloadWeaklyReportState();
  }

  DownloadWeaklyReportState clone() {
    return DownloadWeaklyReportState();
  }

  getScoreHealthData() {}
}

final class DownloadWeaklyReportStateInit extends DownloadWeaklyReportState {}

final class LoadingDownloadWeaklyReportState extends DownloadWeaklyReportState {}

final class ErrorDownloadWeaklyReportState extends DownloadWeaklyReportState {}

final class SuccessDownloadWeaklyReportState extends DownloadWeaklyReportState {
  final String pdfUrlWeakly ;
  SuccessDownloadWeaklyReportState({required this.pdfUrlWeakly});
}

//{"Physiological":0,"Fitness":0,"Emotional":0}