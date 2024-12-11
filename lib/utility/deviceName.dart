/// This file defines a function to detect the platform type in a Flutter application.
/// It uses the `dart:io` library to check the platform and the `flutter/foundation.dart`
/// library to determine if the app is running on the web.

import 'dart:io';
import 'package:flutter/foundation.dart';

// Define an enum for platform types to categorize the platform
enum PlatformType {
  web,      // Represents the web platform
  android,  // Represents the Android platform
  ios,      // Represents the iOS platform
  other,    // Represents any platform other than web, Android, or iOS
}

/// A function that detects the current platform and returns the corresponding [PlatformType].
///
/// The function checks if the app is running on the web, Android, iOS, or any other platform.
/// It returns a value from the [PlatformType] enum based on the current platform.
///
/// Returns:
///   [PlatformType]: The type of platform (web, android, ios, or other).
PlatformType getPlatformType() {
  // Check if the app is running on the web platform
  if (kIsWeb) {
    return PlatformType.web;
  }
  // Check if the app is running on the Android platform
  else if (Platform.isAndroid) {
    return PlatformType.android;
  }
  // Check if the app is running on the iOS platform
  else if (Platform.isIOS) {
    return PlatformType.ios;
  }
  // Return 'other' for any platform that does not match the above
  else {
    return PlatformType.other;
  }
}
