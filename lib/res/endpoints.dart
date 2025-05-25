class Endpoints {
  static const String baseUrl = 'https://api.holisticare.com';
  
  // Auth endpoints
  static const String register = '$baseUrl/mobile_register';
  static const String login = '$baseUrl/mobile_login';
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String resetPassword = '$baseUrl/reset-password';
  
  // Profile endpoints
  static const String profile = '$baseUrl/profile';
  static const String updateProfile = '$baseUrl/profile/update';
  
  // Other endpoints can be added here
} 