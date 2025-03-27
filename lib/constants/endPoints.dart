class Endpoints {
  static const baseUrl = "https://back-copilet-app.vercel.app/";
  // static const baseUrlCodie = "https://vercel-backend-one-roan.vercel.app/clinic_copilot/";
  static const baseUrlCodie = "https://vercel-backend-one-roan.vercel.app/holisticare/";

  // mobile/get_messages_id
  static const biomarker = "${baseUrlCodie}biomarkers_mobile";
  static const login = "${baseUrlCodie}auth/mobile_token";
  static const healthScore = "${baseUrlCodie}health_score_mobile";
  static const downloadPdfReport = "${baseUrlCodie}download_report_mobile";
  static const downloadPdfReportWeakly = "${baseUrlCodie}download_weekly_report_mobile";
  static const add_event = "${baseUrlCodie}mobile/add_event";
  static const clientInformationMobile = "${baseUrlCodie}client_information_mobile";
  static const google_form = "${baseUrlCodie}google_form";
  static const mobile_chat = "${baseUrlCodie}mobile_chat";
  static const getHistoryChat = "${baseUrlCodie}mobile_chat/get_messages_id";
  static const getQuestionary = "${baseUrlCodie}mobile/tasks/show_assigned_questionaries";
  static const getCheckin = "${baseUrlCodie}mobile/tasks/show_checkin_questions";
}
