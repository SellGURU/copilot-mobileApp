import 'package:flutter/material.dart';

/// Utility functions for color handling
class ColorUtils {
  
  /// Calculate luminance of a color (0 = black, 1 = white)
  static double getLuminance(Color color) {
    return color.computeLuminance();
  }
  
  /// Determine if a color is dark or light
  static bool isDark(Color color) {
    return getLuminance(color) < 0.5;
  }
  
  /// Get appropriate text color for a background color
  static Color getTextColor(Color backgroundColor) {
    return isDark(backgroundColor) ? Colors.white : Colors.black;
  }
  
  /// Get appropriate text color for a background color with fallback
  static Color getTextColorWithFallback(Color backgroundColor, {Color? fallbackColor}) {
    final textColor = getTextColor(backgroundColor);
    
    // If the calculated text color is too similar to background, use fallback
    if (fallbackColor != null) {
      final contrast = (getLuminance(backgroundColor) - getLuminance(textColor)).abs();
      if (contrast < 0.3) {
        return fallbackColor;
      }
    }
    
    return textColor;
  }
  
  /// Create a color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  /// Blend two colors
  static Color blend(Color color1, Color color2, double ratio) {
    return Color.lerp(color1, color2, ratio)!;
  }
  
  /// Get complementary color
  static Color getComplementary(Color color) {
    return Color.fromARGB(
      color.alpha,
      255 - color.red,
      255 - color.green,
      255 - color.blue,
    );
  }
  
  /// Check if two colors are similar
  static bool areSimilar(Color color1, Color color2, {double threshold = 0.1}) {
    final luminance1 = getLuminance(color1);
    final luminance2 = getLuminance(color2);
    return (luminance1 - luminance2).abs() < threshold;
  }
  
  /// Get color name for debugging
  static String getColorName(Color color) {
    if (color == Colors.black) return 'Black';
    if (color == Colors.white) return 'White';
    if (color == Colors.red) return 'Red';
    if (color == Colors.green) return 'Green';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.grey) return 'Grey';
    if (color == Colors.brown) return 'Brown';
    if (color == Colors.cyan) return 'Cyan';
    if (color == Colors.teal) return 'Teal';
    if (color == Colors.indigo) return 'Indigo';
    if (color == Colors.lime) return 'Lime';
    if (color == Colors.amber) return 'Amber';
    if (color == Colors.deepOrange) return 'Deep Orange';
    if (color == Colors.deepPurple) return 'Deep Purple';
    if (color == Colors.lightBlue) return 'Light Blue';
    if (color == Colors.lightGreen) return 'Light Green';
    if (color == Colors.grey.shade300) return 'Light Grey';
    if (color == Colors.grey.shade700) return 'Deep Grey';
    
    return 'Custom (${color.value.toRadixString(16).toUpperCase()})';
  }
  
  /// Get color info for debugging
  static String getColorInfo(Color color) {
    return '${getColorName(color)} - RGB(${color.red}, ${color.green}, ${color.blue}) - Luminance: ${getLuminance(color).toStringAsFixed(3)}';
  }
} 