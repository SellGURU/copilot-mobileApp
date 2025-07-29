import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../utility/branding_helper.dart';
import '../models/branding_data.dart';

/// Helper class to set dynamic colors from branding data
class BrandingColorSetter {
  
  /// Set both primary and secondary colors from branding data
  static void setPrimaryColorFromBranding(BrandingData brandingData) {
    
    final primaryColor = hexToColor(brandingData.primaryColorHex);
    final secondaryColor = hexToColor(brandingData.secondaryColorHex);
    
    AppColors.setDynamicPrimaryColor(primaryColor);
    AppColors.setDynamicSecondaryColor(secondaryColor);
    
    // Verify the colors were set
    final currentPrimaryColor = AppColors.dynamicPrimaryColor;
    final currentSecondaryColor = AppColors.dynamicSecondaryColor;
  }
  
  /// Set the dynamic primary color from hex string
  static void setPrimaryColorFromHex(String hexColor) {
    final primaryColor = hexToColor(hexColor);
    AppColors.setDynamicPrimaryColor(primaryColor);
  }
  
  /// Set the dynamic secondary color from hex string
  static void setSecondaryColorFromHex(String hexColor) {
    final secondaryColor = hexToColor(hexColor);
    AppColors.setDynamicSecondaryColor(secondaryColor);
  }
  
  /// Get current dynamic primary color
  static Color getCurrentPrimaryColor() {
    return AppColors.dynamicPrimaryColor;
  }
  
  /// Get current dynamic secondary color
  static Color getCurrentSecondaryColor() {
    return AppColors.dynamicSecondaryColor;
  }
  
  /// Reset to default colors
  static void resetToDefault() {
    AppColors.setDynamicPrimaryColor(AppColors.mainPrimaryColor);
    AppColors.setDynamicSecondaryColor(AppColors.mainSecandaryColor);
  }
} 