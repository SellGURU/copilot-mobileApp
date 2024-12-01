import 'dart:io';
import 'package:flutter/foundation.dart';

// Define enum for platform types
enum PlatformType {
  web,
  android,
  ios,
  other,
}

// Function to detect the platform
PlatformType getPlatformType() {
  if (kIsWeb) {
    return PlatformType.web;
  } else if (Platform.isAndroid) {
    return PlatformType.android;
  } else if (Platform.isIOS) {
    return PlatformType.ios;
  } else {
    return PlatformType.other;
  }
}
