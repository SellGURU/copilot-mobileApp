class Endpoints {
  static const baseUrl = "https://back-copilet-app.vercel.app/";
  static const baseUrlCodie = "https://vercel-backend-one-roan.vercel.app/clinic_copilot/";
  static const biomarker = "${baseUrl}api/getDate";
  static const login = "${baseUrlCodie}auth/mobile_token";
  static const healthScore = "${baseUrlCodie}health_score_mobile";
  static const downloadPdfReport = "${baseUrlCodie}download_report_mobile";
  static const downloadPdfReportWeakly = "${baseUrlCodie}download_weekly_report_mobile";
  static const clientInformationMobile = "${baseUrlCodie}client_information_mobile";
}
