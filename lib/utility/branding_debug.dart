import 'package:flutter/material.dart';
import '../services/branding_service.dart';
import '../models/branding_data.dart';
import '../utility/branding_helper.dart';
import '../res/colors.dart';

/// Debug utility for branding color issues
class BrandingDebug {
  
  /// Print current branding data for debugging
  static void printCurrentBrandingData() {
    print('=== Branding Debug Info ===');
    print('AppColors.dynamicPrimaryColor: ${AppColors.dynamicPrimaryColor}');
    print('AppColors.mainPrimaryColor: ${AppColors.mainPrimaryColor}');
    print('AppColors.mainSecandaryColor: ${AppColors.mainSecandaryColor}');
    
    // Check cached data
    BrandingService.instance.loadBrandingData().then((data) {
      print('BrandingService cached data:');
      print('  Name: ${data.name}');
      print('  Primary Color: ${data.primaryColorHex}');
      print('  Secondary Color: ${data.secondaryColorHex}');
      print('  Converted Primary Color: ${hexToColor(data.primaryColorHex)}');
    }).catchError((error) {
      print('Error loading branding data: $error');
    });
  }
  
  /// Force refresh branding data
  static Future<void> forceRefreshBrandingData() async {
    print('=== Force Refreshing Branding Data ===');
    try {
      final data = await BrandingService.instance.refreshBrandingData();
      print('Refreshed data:');
      print('  Name: ${data.name}');
      print('  Primary Color: ${data.primaryColorHex}');
      print('  Converted Color: ${hexToColor(data.primaryColorHex)}');
    } catch (e) {
      print('Error refreshing: $e');
    }
  }
  
  /// Test color conversion
  static void testColorConversion() {
    print('=== Testing Color Conversion ===');
    final testColors = ['#000000', '#FF0000', '#00FF00', '#0000FF', '#FFFFFF'];
    
    for (final hex in testColors) {
      final color = hexToColor(hex);
      print('$hex -> $color');
    }
  }
  
  /// Create a debug widget that shows all branding info
  static Widget debugWidget() {
    return FutureBuilder<BrandingData>(
      future: BrandingService.instance.loadBrandingData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Loading branding data...'),
            ),
          );
        }
        
        if (snapshot.hasError) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        
        final data = snapshot.data!;
        final primaryColor = hexToColor(data.primaryColorHex);
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Branding Debug Info',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                Text('Name: ${data.name}'),
                Text('Primary Color Hex: ${data.primaryColorHex}'),
                Text('Primary Color Object: $primaryColor'),
                Text('AppColors.dynamicPrimaryColor: ${AppColors.dynamicPrimaryColor}'),
                Text('AppColors.mainPrimaryColor: ${AppColors.mainPrimaryColor}'),
                
                const SizedBox(height: 16),
                
                // Color comparison
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        color: primaryColor,
                        child: const Center(
                          child: Text(
                            'API Color',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 50,
                        color: AppColors.dynamicPrimaryColor,
                        child: const Center(
                          child: Text(
                            'AppColors',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                ElevatedButton(
                  onPressed: () {
                    BrandingDebug.forceRefreshBrandingData();
                  },
                  child: const Text('Force Refresh'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 