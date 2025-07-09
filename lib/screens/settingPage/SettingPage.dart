import 'package:copilet/components/text_style.dart';
import 'package:copilet/screens/Wearable%20Device/WearableDevice.dart';
import 'package:copilet/widgets/notification_widget.dart';
import 'package:copilet/widgets/restart/RestartWidget.dart';
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

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    DateTime now = DateTime.now();
    // Format the date to show month name and day
    String formattedDate = DateFormat('MMMM, d').format(now);
    // 00
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        margin:EdgeInsets.only(top: size.height * .02),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
          width:  size.width,
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
                        title: "⚠ Your HRV Trend is Lower",
                        message: "Based on recent Heart Rate Variability, your Resilience Protocol needs a slight adjustment for optimal recovery.",
                        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
                        type: NotificationType.info,
                        isRead: false,
                      ),
                      NotificationItem(
                        title: "🌙 Sleep Dip Detected!",
                        message: "AI suggests a brief Mindfulness session today and a slight adjustment to evening supplements for enhanced recovery.",
                        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
                        type: NotificationType.info,
                        isRead: false,
                      ),                    
                    ],      
                  ),                  
                  // SvgPicture.asset("assets/notification.svg",width: 24,height: 24,)
                ],
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   formattedDate,
              //   style: AppTextStyles.titleXl,
              // ),
              const SizedBox(
                height: 20,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => WearableDevice()));
              //   },
              //   child: WearableDevicesTile(
              //     srcImage: 'watch-status.svg',
              //     textTitle: 'Wearable Devices',
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // WearableDevicesTile(
              //   srcImage: 'lock.svg',
              //   textTitle: 'Change Password',
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              GestureDetector(
                onTap: () {
                  _launchURL('https://holisticare.io/privacy-policy/');
                },
                  child:WearableDevicesTile(
                  srcImage: 'lock.svg',
                  textTitle: 'Privacy Policy',
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _launchURL('https://holisticare.io/terms-of-service/');
                },
                child:WearableDevicesTile(
                srcImage: 'security-safe.svg',
                textTitle: 'Terms of Service',
              ),
              ),
            
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      // Clear all tokens and data, reset everything
                      await BlocProvider.of<AuthCubit>(context).logOut();
                      // Navigate to login page and clear the navigation stack
                      RestartWidget.restartApp(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/logout.svg",
                          width: 30,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                              AppColors.mainSecandaryColor, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Log out",
                          style: AppTextStyles.title2Purple,
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
              SvgPicture.asset("assets/setting/${srcImage}",color: AppColors.mainSecandaryColor,),
              const SizedBox(width: 12),
              // Title
              Text(
                textTitle,
                style: AppTextStyles.hintMedium
              ),
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
