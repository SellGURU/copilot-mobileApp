import 'package:flutter/material.dart';
import '../res/colors.dart';

/// A reactive widget that automatically updates when branding colors change
class ReactiveBrandingWidget extends StatelessWidget {
  final Widget Function(Color primaryColor) builder;
  
  const ReactiveBrandingWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: AppColors.dynamicPrimaryColorNotifier,
      builder: (context, primaryColor, child) {
        return builder(primaryColor);
      },
    );
  }
}

/// Example usage widgets
class ReactiveBrandingExamples {
  
  /// Example 1: Reactive text with branding color
  static Widget reactiveText(String text) {
    return ReactiveBrandingWidget(
      builder: (primaryColor) => Text(
        text,
        style: TextStyle(
          color: primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  /// Example 2: Reactive container with branding color
  static Widget reactiveContainer({required Widget child}) {
    return ReactiveBrandingWidget(
      builder: (primaryColor) => Container(
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
  
  /// Example 3: Reactive button with branding color
  static Widget reactiveButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ReactiveBrandingWidget(
      builder: (primaryColor) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
  
  /// Example 4: Reactive card with branding color
  static Widget reactiveCard({
    required Widget child,
    double elevation = 4,
  }) {
    return ReactiveBrandingWidget(
      builder: (primaryColor) => Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: primaryColor, width: 2),
        ),
        child: child,
      ),
    );
  }
  
  /// Example 5: Reactive app bar with branding color
  static Widget reactiveAppBar({
    required String title,
    List<Widget>? actions,
  }) {
    return ReactiveBrandingWidget(
      builder: (primaryColor) => AppBar(
        backgroundColor: primaryColor,
        title: Text(title),
        actions: actions,
      ),
    );
  }
} 