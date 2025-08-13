import 'package:copilet/components/text_style.dart';
import 'package:copilet/screens/Wearable%20Device/SahhaConnect.dart';
import 'package:copilet/screens/Wearable%20Device/WearableDevice.dart';
import 'package:copilet/services/branding_service.dart';
import 'package:copilet/widgets/notification_widget.dart';
import 'package:copilet/widgets/restart/RestartWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/colors.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';
import '../login/login.dart'; // For date formatting
import 'package:flutter/foundation.dart';
import 'package:copilet/screens/privacyPolicy/privacyPolicy.dart';
import 'package:copilet/screens/termsOfService/termsOfService.dart';

class SettingPage extends StatefulWidget {
  final ValueChanged<bool>? onLogoutModalChanged;
  const SettingPage({super.key, this.onLogoutModalChanged});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      // Handle error silently or show a toast if needed
      print('Could not launch URL: $url');
    }
  }

  void _showLogoutConfirmation() {
    widget.onLogoutModalChanged?.call(true);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgScreen,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Log out',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.onLogoutModalChanged?.call(false);
                      },
                      child: ValueListenableBuilder<Color>(
                        valueListenable: AppColors.dynamicPrimaryColorNotifier,
                        builder: (context, primaryColor, child) {
                          return Icon(Icons.close,
                              size: 24, color: primaryColor);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'You are attempting to log out. Are you sure?',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: AppColors.dynamicSecondaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onLogoutModalChanged?.call(false);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.dynamicSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.dynamicSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          await BlocProvider.of<AuthCubit>(context).logOut();
                          RestartWidget.restartApp(context);
                          Navigator.of(context).pop();
                          widget.onLogoutModalChanged?.call(false);
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).then((_) {
      // This ensures the callback is called even if the modal is dismissed by tapping outside
      widget.onLogoutModalChanged?.call(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, MMMM d');
    final formattedDate = formatter.format(now);

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: Container(
        height: size.height,
        width: size.width,
        margin: EdgeInsets.only(top: size.height * .02),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Setting",
                      style: AppTextStyles.title1,
                    ),
                    NotificationWidget(
                      notificationCount: 2,
                      notifications: [
                        NotificationItem(
                          title: "New Tasks, New You!",
                          message:
                              "Your latest health action plan is ready! Check out your new tasks in the Overview section and take the next step toward a longer, healthier life.",
                          timestamp: DateTime.now()
                              .subtract(const Duration(minutes: 1)),
                          type: NotificationType.info,
                          isRead: false,
                        ),
                        NotificationItem(
                          title: "Your Progress Awaits!",
                          message:
                              "Ready to level up your health? Complete your Health Questionnaire to help us build a more personalized and effective wellness plan just for you.",
                          timestamp: DateTime.now()
                              .subtract(const Duration(minutes: 1)),
                          type: NotificationType.info,
                          isRead: false,
                        ),
                      ],
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     _launchURL('https://holisticare.io/privacy-policy/');
                //   },
                //     child:WearableDevicesTile(
                //     srcImage: 'lock.svg',
                //     textTitle: 'Privacy Policy',
                //   ),
                // ),

                // const SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     _launchURL('https://holisticare.io/terms-of-service/');
                //   },
                //   child:WearableDevicesTile(
                //   srcImage: 'security-safe.svg',
                //   textTitle: 'Terms of Service',
                // ),
                // ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const WearableDevicePage()),
                    );
                  },
                  child: WearableDevicesTile(
                    srcImage: 'watch-status.svg',
                    textTitle: 'Wearable Device',
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyPage()),
                    );
                  },
                  child: WearableDevicesTile(
                    srcImage: 'security-safe.svg',
                    textTitle: 'Privacy Policy',
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TermsOfServicePage()),
                    );
                  },
                  child: WearableDevicesTile(
                    srcImage: 'shield-tick.svg',
                    textTitle: 'Terms of Service',
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        _showLogoutConfirmation();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/logout.svg",
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                                AppColors.dynamicSecondaryColor,
                                BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Log Out",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.dynamicSecondaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WearableDevicesTile extends StatelessWidget {
  String srcImage;
  String textTitle;
  WearableDevicesTile({required this.srcImage, required this.textTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Icon
          Row(
            children: [
              SvgPicture.asset(
                "assets/setting/${srcImage}",
                color: AppColors.mainSecandaryColor,
              ),
              const SizedBox(width: 12),
              // Title
              Text(textTitle, style: AppTextStyles.hintMedium),
            ],
          ),
          // Right Arrow Icon
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: AppColors.mainSecandaryColor,
          ),
        ],
      ),
    );
  }
}
