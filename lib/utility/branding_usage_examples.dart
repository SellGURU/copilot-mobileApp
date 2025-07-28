import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/branding_bloc.dart';
import '../widgets/branding_display.dart';
import '../utility/branding_helper.dart';

/// Examples of how to use branding data throughout the application
class BrandingUsageExamples {
  
  /// Example 1: Using branding data in a widget with BlocBuilder
  static Widget exampleWithBlocBuilder() {
    return BlocBuilder<BrandingBloc, BrandingState>(
      builder: (context, state) {
        if (state is BrandingLoaded) {
          final brandingData = state.data;
          return Container(
            color: hexToColor(brandingData.primaryColorHex).withOpacity(0.1),
            child: Text(
              brandingData.title,
              style: TextStyle(
                color: hexToColor(brandingData.primaryColorHex),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Example 2: Using BrandingDataHelper to get data anywhere
  static Widget exampleWithHelper(BuildContext context) {
    final primaryColor = BrandingDataHelper.getPrimaryColor(context);
    final title = BrandingDataHelper.getTitle(context);
    
    return Container(
      color: primaryColor.withOpacity(0.1),
      child: Text(
        title,
        style: TextStyle(color: primaryColor),
      ),
    );
  }

  /// Example 3: Using the pre-built BrandingDisplay widget
  static Widget exampleWithDisplayWidget() {
    return const BrandingDisplay();
  }

  /// Example 4: Using branding data in AppBar
  static PreferredSizeWidget exampleAppBar(BuildContext context) {
    final state = context.read<BrandingBloc>().state;
    Color backgroundColor = Colors.white;
    String title = 'Holisticare';
    
    if (state is BrandingLoaded) {
      backgroundColor = hexToColor(state.data.primaryColorHex);
      title = state.data.title;
    }
    
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      actions: const [
        BrandingRefreshButton(),
      ],
    );
  }

  /// Example 5: Using branding data in Theme
  static ThemeData exampleTheme(BuildContext context) {
    final state = context.read<BrandingBloc>().state;
    Color primaryColor = Colors.blue;
    
    if (state is BrandingLoaded) {
      primaryColor = hexToColor(state.data.primaryColorHex);
    }
    
    return Theme.of(context).copyWith(
      primaryColor: primaryColor,
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: primaryColor,
      ),
    );
  }

  /// Example 6: Loading branding data programmatically
  static void loadBrandingData(BuildContext context) {
    context.read<BrandingBloc>().add(LoadBrandingData());
  }

  /// Example 7: Refreshing branding data
  static void refreshBrandingData(BuildContext context) {
    context.read<BrandingBloc>().add(RefreshBrandingData());
  }

  /// Example 8: Using branding data in a custom widget
  static Widget customBrandingWidget(BuildContext context) {
    return BlocBuilder<BrandingBloc, BrandingState>(
      builder: (context, state) {
        if (state is BrandingLoaded) {
          final brandingData = state.data;
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    brandingData.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    brandingData.slogan,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 4,
                    decoration: BoxDecoration(
                      color: hexToColor(brandingData.primaryColorHex),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

/// Usage instructions:
/// 
/// 1. To use branding data in any widget:
///    - Use BlocBuilder<BrandingBloc, BrandingState>
///    - Or use BrandingDataHelper.getCurrentBrandingData(context)
/// 
/// 2. To load branding data:
///    - context.read<BrandingBloc>().add(LoadBrandingData())
/// 
/// 3. To refresh branding data:
///    - context.read<BrandingBloc>().add(RefreshBrandingData())
/// 
/// 4. To use the pre-built widget:
///    - Just add BrandingDisplay() to your widget tree
/// 
/// 5. To get specific branding data:
///    - BrandingDataHelper.getTitle(context)
///    - BrandingDataHelper.getPrimaryColor(context)
///    - BrandingDataHelper.getSlogan(context) 