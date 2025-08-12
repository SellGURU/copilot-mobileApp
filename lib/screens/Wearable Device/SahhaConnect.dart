import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sahha_flutter/sahha_flutter.dart';

class WearableConnectPage extends StatefulWidget {
  const WearableConnectPage({super.key});

  @override
  State<WearableConnectPage> createState() => _WearableConnectPageState();
}

class _WearableConnectPageState extends State<WearableConnectPage> {
  String log = "Waiting...";

  @override
  void initState() {
    super.initState();
    initSahha();
  }

  Future<void> initSahha() async {
    try {
      // 1️⃣ گرفتن پرمیشن‌ها
      await Permission.activityRecognition.request();
      await Permission.sensors.request();

      // 2️⃣ کانفیگ Sahha
      bool configured = await SahhaFlutter.configure(
        environment: SahhaEnvironment.sandbox, // یا production
      );
      setState(() => log = "Configured: $configured");

      // 3️⃣ احراز هویت
      bool authenticated = await SahhaFlutter.authenticate(
        appId: 'o6rAnanD0tnm877eT73dV8BQhSvOEC7b',
        appSecret: 'ayjYop9i8ZBPt7AFCvtfeLyXKBICFEa99aaCASGOPik4LgeqSQ7nROq0g3HndAOv',
        externalId: 'SampleProfile-cb79d25f-f743-4d2b-b80b-ac943ecb5918',
      );
      setState(() => log += "\nAuthenticated: $authenticated");

      // 4️⃣ فعال کردن سنسورها
      final sensors = [
        SahhaSensor.steps,
        SahhaSensor.sleep,
        SahhaSensor.heart_rate,
      ];
      var status = await SahhaFlutter.getSensorStatus(sensors);
      setState(() => log += "\nSensor status: $status");

      var enabledStatus = await SahhaFlutter.enableSensors(sensors);
      setState(() => log += "\nSensors enabled: $enabledStatus");
    } catch (e) {
      setState(() => log = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wearable Device")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(log),
        ),
      ),
    );
  }
}
