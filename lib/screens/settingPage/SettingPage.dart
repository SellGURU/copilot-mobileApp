import 'package:copilet/components/text_style.dart';
import 'package:copilet/screens/Wearable%20Device/WearableDevice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    DateTime now = DateTime.now();
    // Format the date to show month name and day
    String formattedDate = DateFormat('MMMM, d').format(now);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          height: size.height,
          width: size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 25),
            width: kIsWeb ? (size.width > 420 ? 420 : size.width) : size.width,
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
                    SvgPicture.asset("assets/notification.svg",width: 24,height: 24,)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  formattedDate,
                  style: AppTextStyles.titleXl,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WearableDevice()),
                    );
                  },
                  child: WearableDevicesTile(
                    srcImage: 'watch-status.svg',
                    textTitle: 'Wearable Devices',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                WearableDevicesTile(
                  srcImage: 'lock.svg',
                  textTitle: 'Change Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                WearableDevicesTile(
                  srcImage: 'lock.svg',
                  textTitle: 'Privacy Policy',
                ),
                const SizedBox(
                  height: 20,
                ),
                WearableDevicesTile(
                  srcImage: 'security-safe.svg',
                  textTitle: 'Terms of Service',
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        await BlocProvider.of<AuthCubit>(context).logOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
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
                                AppColors.purpleDark, BlendMode.srcIn),
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
              SvgPicture.asset("assets/setting/${srcImage}"),
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
            color: AppColors.purpleDark,
          ),
        ],
      ),
    );
  }
}
