import 'dart:convert';
import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahha_flutter/sahha_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WearableDevicePage extends StatefulWidget {
  const WearableDevicePage({super.key});

  @override
  State<WearableDevicePage> createState() => _WearableDevicePageState();
}

class _WearableDevicePageState extends State<WearableDevicePage> {
  bool loading = false;
  String log = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initSahha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('userInfoid');   
    String userId = jsonDecode(storedUserId!); 
    setState(() {
      loading = true;
      log = "Configuring Sahha...";
    });

    try {
      // Step 1: Configure Sahha
      bool configured = await SahhaFlutter.configure(
        environment: SahhaEnvironment.sandbox,
      );

      if (!configured) {
        throw "Sahha configuration failed";
      }

      setState(() {
        log = "Configuration successful! Authenticating...";
      });

      // Step 2: Authenticate
      bool authSuccess = await SahhaFlutter.authenticate(
        appId: "o6rAnanD0tnm877eT73dV8BQhSvOEC7b",
        appSecret: "ayjYop9i8ZBPt7AFCvtfeLyXKBICFEa99aaCASGOPik4LgeqSQ7nROq0g3HndAOv",
        externalId: userId,
      );

      if (!authSuccess) {
        throw "Authentication failed";
      }

      setState(() {
        log = "Authentication successful! Checking sensors...";
      });

      // Step 3: Check sensor status
      SahhaSensorStatus status = await SahhaFlutter.getSensorStatus(
        [SahhaSensor.steps, SahhaSensor.sleep],
      );

      if (status == SahhaSensorStatus.pending) {
        setState(() {
          log = "Sensors pending. Requesting permissions...";
        });

        // Step 4: Enable sensors (returns SahhaSensorStatus now)
        SahhaSensorStatus enableStatus = await SahhaFlutter.enableSensors(
          [SahhaSensor.steps, SahhaSensor.sleep],
        );

        setState(() {
          loading = false;
          if (enableStatus == SahhaSensorStatus.enabled) {
            log = "Sensors enabled. Device is ready.";
          } else if (enableStatus == SahhaSensorStatus.pending) {
            log = "User did not complete enabling sensors.";
          } else {
            log = "Sensors could not be enabled.";
          }
        });
      } else if (status == SahhaSensorStatus.enabled) {
        setState(() {
          loading = false;
          log = "Sensors already enabled and ready.";
        });
      } else {
        setState(() {
          loading = false;
          log = "Sensors disabled or unavailable.";
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
        log = "Error: $e";
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      appBar: AppBar(
        leadingWidth: 60,
        titleSpacing: 0,
        title: const Text(
          'Wearable Device',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.bgScreen,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 7, bottom: 7),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset('assets/arrow-left.svg'),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        elevation: 0,
      ),
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/wearabledevice.svg'),
              const SizedBox(height: 0),
              Text(
                "Connect to Wearable Devices",
                // textAlign: TextAlign.center,
                style: AppTextStyles.headline5,
              ),
              const SizedBox(height: 16),
              Text(
                "We need your permission to connect with your wearable device and access its data (e.g. heart rate, steps, sensor data). This will allow the app to sync information seamlessly and provide you with real-time insights.",
                style: AppTextStyles.body2.copyWith(),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap:loading ? null : _initSahha,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDeepTeal,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 1, // 1px
                    ),
                  ),
                  width: double.infinity,
                  // width: size.width,
                  child: Text(
                    "Allow Access",
                    style: AppTextStyles.titleMediumWhite,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              if (log.isNotEmpty)
                Text(
                  log,
                  style:
                      const TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
