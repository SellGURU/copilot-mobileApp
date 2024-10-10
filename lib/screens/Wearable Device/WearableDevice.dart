import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WearableDevice extends StatefulWidget {
  const WearableDevice({super.key});

  @override
  State<WearableDevice> createState() => _WearableDeviceState();
}

class _WearableDeviceState extends State<WearableDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wearable Device"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Sync your health data effortlessly by connecting with Health Applications. By integrating, track your progress across all your devices, and make the most of your health journey.",
              style: AppTextStyles.titleMediumHeight,
            ),
            const SizedBox(
              height: 20,
            ),
            ConnectCard(
              image: '',
              link: '',
              title: '',
            )
          ],
        ),
      ),
    );
  }
}

class ConnectCard extends StatelessWidget {
  String link;
  String image;
  String title;
  ConnectCard(
      {super.key,
      required this.image,
      required this.link,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset("assets/fitbit.svg")),
            const SizedBox(width: 16),
            // Text information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Apple Health', style: AppTextStyles.hintMedium),
                  const SizedBox(height: 4),
                  Text('Version: 1,2,3', style: AppTextStyles.hint),
                ],
              ),
            ),
            // Connect button
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                // primary: Colors.transparent,
                // onPrimary: Colors.purple,
                side:
                    const BorderSide(color: AppColors.iconPurpleDark, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Connect', style: AppTextStyles.hintPurple),
            ),
          ],
        ),
      ),
    );
  }
}
