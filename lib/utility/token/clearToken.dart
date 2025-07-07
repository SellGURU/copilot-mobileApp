import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> clearToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Clear all stored data
  await prefs.remove('token');
  await prefs.remove('encode');
  await prefs.remove('email');
  await prefs.remove('password');
  await prefs.remove('name');
  await prefs.remove('userInfoid');
  await prefs.remove('buttonPressTime');
}

/// Check if user should be logged out based on session timeout
Future<bool> shouldForceLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Check if there's a logout timestamp
  String? logoutTimestamp = prefs.getString('logoutTimestamp');
  if (logoutTimestamp != null) {
    // If logout timestamp exists, user should be logged out
    await prefs.remove('logoutTimestamp');
    return true;
  }
  
  return false;
}

/// Set logout timestamp when user logs out
Future<void> setLogoutTimestamp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('logoutTimestamp', DateTime.now().toIso8601String());
}

/// Comprehensive logout function that clears all data and resets everything
Future<void> clearAllDataAndReset() async {
  try {
    // Set logout timestamp to force logout on next app start
    await setLogoutTimestamp();
    
    // Clear all SharedPreferences data
    await clearToken();
    
    // Clear any temporary files or cache
    try {
      final tempDir = await getTemporaryDirectory();
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    } catch (e) {
      // Ignore errors if temp directory doesn't exist or can't be cleared
      print('Could not clear temp directory: $e');
    }
    
    // Clear app documents directory if it contains user data
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      if (appDocDir.existsSync()) {
        final files = appDocDir.listSync();
        for (var file in files) {
          if (file is File) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      // Ignore errors if documents directory doesn't exist or can't be cleared
      print('Could not clear documents directory: $e');
    }
    
  } catch (e) {
    print('Error during data clearing: $e');
    // Even if there's an error, still try to clear SharedPreferences
    await clearToken();
  }
}