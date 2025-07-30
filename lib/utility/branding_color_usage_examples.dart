import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../utility/branding_color_setter.dart';
import '../services/branding_bloc.dart';
import '../widgets/branding_display.dart';

/// Examples of how to use dynamic colors from branding data
class BrandingColorUsageExamples {
  
  /// Example 1: Using dynamic color directly from AppColors
  static Widget exampleWithAppColors() {
    return Container(
      color: AppColors.dynamicPrimaryColor.withOpacity(0.1),
      child: Text(
        'متن با رنگ دینامیک',
        style: TextStyle(
          color: AppColors.dynamicPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  /// Example 2: Using BrandingColorSetter helper
  static Widget exampleWithColorSetter(BuildContext context) {
    return Container(
      color: BrandingColorSetter.getCurrentPrimaryColor().withOpacity(0.1),
      child: Text(
        'متن با رنگ از ColorSetter',
        style: TextStyle(
          color: BrandingColorSetter.getCurrentPrimaryColor(),
        ),
      ),
    );
  }
  
  /// Example 3: Button with dynamic color
  static Widget exampleButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.dynamicPrimaryColor,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        // Button action
      },
      child: const Text('دکمه با رنگ دینامیک'),
    );
  }
  
  /// Example 4: Card with dynamic border
  static Widget exampleCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.dynamicPrimaryColor,
          width: 2,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('کارت با بوردر دینامیک'),
      ),
    );
  }
  
  /// Example 5: AppBar with dynamic color
  static PreferredSizeWidget exampleAppBar() {
    return AppBar(
      backgroundColor: AppColors.dynamicPrimaryColor,
      title: const Text('عنوان با رنگ دینامیک'),
      actions: const [
        BrandingRefreshButton(),
      ],
    );
  }
  
  /// Example 6: Container with gradient
  static Widget exampleGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.dynamicPrimaryColor.withOpacity(0.8),
            AppColors.dynamicPrimaryColor.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'گرادیانت با رنگ دینامیک',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
  
  /// Example 7: Using secondary color
  static Widget exampleSecondaryColor(BuildContext context) {
    return Container(
      color: BrandingDataHelper.getSecondaryColor(context).withOpacity(0.1),
      child: Text(
        'متن با رنگ ثانویه',
        style: TextStyle(
          color: BrandingDataHelper.getSecondaryColor(context),
        ),
      ),
    );
  }
  
  /// Example 8: Card with both primary and secondary colors
  static Widget exampleDualColorCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.dynamicPrimaryColor.withOpacity(0.1),
              BrandingDataHelper.getSecondaryColor(context).withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                BrandingDataHelper.getTitle(context),
                style: TextStyle(
                  color: AppColors.dynamicPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                BrandingDataHelper.getSlogan(context),
                style: TextStyle(
                  color: BrandingDataHelper.getSecondaryColor(context),
                ),
              ),
              if (BrandingDataHelper.getTone(context).isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Tone: ${BrandingDataHelper.getTone(context)}',
                  style: TextStyle(
                    color: AppColors.dynamicPrimaryColor,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  /// Example 9: Setting color manually
  static void setColorManually(String hexColor) {
    BrandingColorSetter.setPrimaryColorFromHex(hexColor);
  }
  
  /// Example 10: Reset to default color
  static void resetColor() {
    BrandingColorSetter.resetToDefault();
  }
  
  /// Example 11: Theme with dynamic color
  static ThemeData exampleTheme() {
    return ThemeData(
      primaryColor: AppColors.dynamicPrimaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.dynamicPrimaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.dynamicPrimaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

/// Usage instructions:
/// 
/// 1. رنگ دینامیک به طور خودکار در AppColors.dynamicPrimaryColor ست می‌شود
/// 2. می‌توانید مستقیماً از AppColors.dynamicPrimaryColor استفاده کنید
/// 3. برای ست کردن دستی: BrandingColorSetter.setPrimaryColorFromHex("#FF0000")
/// 4. برای ریست کردن: BrandingColorSetter.resetToDefault()
/// 5. رنگ در زمان بارگذاری branding data به طور خودکار ست می‌شود
/// 6. برای رنگ ثانویه: BrandingDataHelper.getSecondaryColor(context)
/// 7. برای اطلاعات اضافی: BrandingDataHelper.getTone(context), BrandingDataHelper.getFocusArea(context) 