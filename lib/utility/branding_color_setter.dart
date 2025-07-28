import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../utility/branding_helper.dart';
import '../models/branding_data.dart';

/// Helper class to set dynamic colors from branding data
class BrandingColorSetter {
  
  /// Set the dynamic primary color from branding data
  static void setPrimaryColorFromBranding(BrandingData brandingData) {
    final primaryColor = hexToColor(brandingData.primaryColorHex);
    AppColors.setDynamicPrimaryColor(primaryColor);
  }
  
  /// Set the dynamic primary color from hex string
  static void setPrimaryColorFromHex(String hexColor) {
    final primaryColor = hexToColor(hexColor);
    AppColors.setDynamicPrimaryColor(primaryColor);
  }
  
  /// Get current dynamic primary color
  static Color getCurrentPrimaryColor() {
    return AppColors.dynamicPrimaryColor;
  }
  
  /// Reset to default color
  static void resetToDefault() {
    AppColors.setDynamicPrimaryColor(AppColors.mainPrimaryColor);
  }
} 