import 'package:copilet/components/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WearableDevice extends StatefulWidget {
  const WearableDevice({super.key});

  @override
  State<WearableDevice> createState() => _WearableDeviceState();
}

class _WearableDeviceState extends State<WearableDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
           Text("Sync your health data effortlessly by connecting with Health Applications. By integrating, track your progress across all your devices, and make the most of your health journey.",style: AppTextStyles.titleMedium,)

        ],
      ),
    );
  }
}
