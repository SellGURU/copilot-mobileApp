import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/branding_bloc.dart';
import '../utility/branding_helper.dart';
import '../res/colors.dart';
import '../models/branding_data.dart';

class BrandingDisplay extends StatelessWidget {
  const BrandingDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandingBloc, BrandingState>(
      builder: (context, state) {
        if (state is BrandingLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.mainSecandaryColor,
            ),
          );
        }

        if (state is BrandingLoaded) {
          final brandingData = state.data;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hexToColor(brandingData.primaryColorHex).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hexToColor(brandingData.primaryColorHex),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brandingData.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  brandingData.headline,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (brandingData.tone.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Tone: ${brandingData.tone}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                if (brandingData.focusArea.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Focus: ${brandingData.focusArea}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: hexToColor(brandingData.primaryColorHex),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is BrandingError) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red),
            ),
            child: const Text(
              'خطا در بارگذاری اطلاعات برندینگ',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// Helper widget to refresh branding data
class BrandingRefreshButton extends StatelessWidget {
  const BrandingRefreshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<BrandingBloc>().add(RefreshBrandingData());
      },
      icon: const Icon(Icons.refresh),
      tooltip: 'بروزرسانی اطلاعات برندینگ',
    );
  }
}

// Helper widget to get branding data anywhere in the app
class BrandingDataHelper {
  static BrandingData? getCurrentBrandingData(BuildContext context) {
    final state = context.read<BrandingBloc>().state;
    if (state is BrandingLoaded) {
      return state.data;
    }
    return null;
  }

  static Color getPrimaryColor(BuildContext context) {
    final brandingData = getCurrentBrandingData(context);
    if (brandingData != null) {
      return hexToColor(brandingData.primaryColorHex);
    }
    return AppColors.mainSecandaryColor; // fallback color
  }

  static String getTitle(BuildContext context) {
    final brandingData = getCurrentBrandingData(context);
    return brandingData?.name ?? 'Holisticare';
  }

  static String getSlogan(BuildContext context) {
    final brandingData = getCurrentBrandingData(context);
    return brandingData?.headline ?? '';
  }

  static String getTone(BuildContext context) {
    final brandingData = getCurrentBrandingData(context);
    return brandingData?.tone ?? '';
  }

  static String getFocusArea(BuildContext context) {
    final brandingData = getCurrentBrandingData(context);
    return brandingData?.focusArea ?? '';
  }

  static Color getSecondaryColor(BuildContext context) {
    final brandingData = getCurrentBrandingData(context);
    if (brandingData != null) {
      return hexToColor(brandingData.secondaryColorHex);
    }
    return AppColors.mainPrimaryColor; // fallback color
  }
} 