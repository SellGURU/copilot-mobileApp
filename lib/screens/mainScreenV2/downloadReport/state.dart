class DownloadPdfState {
  DownloadPdfState init() {
    return DownloadPdfState();
  }

  DownloadPdfState clone() {
    return DownloadPdfState();
  }

  getScoreHealthData() {}
}

final class BiomarkerInit extends DownloadPdfState {}

final class LoadingDownloadPdf extends DownloadPdfState {}

final class ErrorDownloadPdf extends DownloadPdfState {}

final class SuccessDownloadPdf extends DownloadPdfState {
  final String pdfUrl ;
  SuccessDownloadPdf({required this.pdfUrl});
}

//{"Physiological":0,"Fitness":0,"Emotional":0}