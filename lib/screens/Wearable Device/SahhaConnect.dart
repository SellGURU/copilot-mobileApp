import 'dart:convert';
import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahha_flutter/sahha_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:copilet/constants/endPoints.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class WearableDevicePage extends StatefulWidget {
  const WearableDevicePage({super.key});

  @override
  State<WearableDevicePage> createState() => _WearableDevicePageState();
}

class _WearableDevicePageState extends State<WearableDevicePage> {
  bool connecting = false;
  bool success = false;
  String log = "";
  String titleText = "Connect to Wearable Devices";
  String descText =
      "We need your permission to connect with your wearable device and access its data (e.g. heart rate, steps, sensor data). This will allow the app to sync information seamlessly and provide you with real-time insights.";

  @override
  void initState() {
    super.initState();
    _checkSavedStatus();
    _getAndEncryptKeys();
  }

  Future<void> _checkSavedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool alreadyConnected = prefs.getBool('wearableConnected') ?? false;
    if (alreadyConnected) {
      setState(() {
        success = true;
        titleText = "Device connected successfully!";
        descText = "Your wearable device is now synced and ready.";
      });
    }
  }

  String? encryptedKey;
  String? encryptedSecret;

  Future<void> _getAndEncryptKeys() async {
    final response = await http.post(Uri.parse(Endpoints.get_keys));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final originalKey = data['key'];
      final originalSecret = data['secret'];

      const keyString = 'Hello12345678910'; // کلید ثابت
      final key = encrypt.Key.fromUtf8(keyString);

      String encryptValue(String value) {
        final iv = encrypt.IV.fromSecureRandom(16);
        final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
        );

        final encrypted = encrypter.encrypt(value, iv: iv);

        // فرمت خروجی: iv:cipher
        return '${iv.base64}:${encrypted.base64}';
      }

      setState(() {
        encryptedKey = encryptValue(originalKey);
        encryptedSecret = encryptValue(originalSecret);
      });
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  }

  Future<void> _initSahha() async {
    setState(() {
      connecting = true;
      titleText = "Connecting to your wearable…";
      descText =
          "Your device is syncing data now. Please wait while we complete the process.";
    });

    if (kIsWeb) {
      // حالت وب که ساپورت نمیشه → بعد از 5 ثانیه موفقیت نشون میدیم
      await Future.delayed(const Duration(seconds: 5));
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('wearableConnected', true);
      setState(() {
        connecting = false;
        success = true;
        titleText = "Use Our Mobile App to Connect";
        descText = "Currently, connecting to wearable devices is only supported through our mobile application—not available on the web. Please open our mobile app on your phone to establish a connection and sync data smoothly.";
        log = "";
      });
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedUserId = prefs.getString('userInfoid');
      String userId = jsonDecode(storedUserId!);

      bool configured = await SahhaFlutter.configure(
        environment: SahhaEnvironment.sandbox,
      );
      if (!configured) throw "Sahha configuration failed";

      bool authSuccess = await SahhaFlutter.authenticate(
        appId: "o6rAnanD0tnm877eT73dV8BQhSvOEC7b",
        appSecret:
            "ayjYop9i8ZBPt7AFCvtfeLyXKBICFEa99aaCASGOPik4LgeqSQ7nROq0g3HndAOv",
        externalId: userId,
      );
      if (!authSuccess) throw "Authentication failed";

      SahhaSensorStatus status = await SahhaFlutter.getSensorStatus(
        [SahhaSensor.steps, SahhaSensor.sleep],
      );

      if (status == SahhaSensorStatus.pending) {
        SahhaSensorStatus enableStatus = await SahhaFlutter.enableSensors(
          [SahhaSensor.steps, SahhaSensor.sleep],
        );
        if (enableStatus == SahhaSensorStatus.enabled) {
          await prefs.setBool('wearableConnected', true);
          setState(() {
            connecting = false;
            success = true;
            titleText = "Connected!";
            descText = "Your wearable is now linked and ready to sync data.";
            log = "";
          });
        } else {
          setState(() {
            connecting = false;
            success = false;
            log = "User did not complete enabling sensors.";
          });
        }
      } else if (status == SahhaSensorStatus.enabled) {
        await prefs.setBool('wearableConnected', true);
        setState(() {
          connecting = false;
          success = true;
          titleText = "Device connected successfully!";
          descText = "Your wearable device is now synced and ready.";
          log = "";
        });
      } else {
        setState(() {
          connecting = false;
          success = false;
          log = "Sensors disabled or unavailable.";
        });
      }
    } catch (e) {
      setState(() {
        connecting = false;
        success = false;
        log = "Error: $e";
      });
    }
  }

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
              if (connecting)
                const CircularProgressIndicator()
              else if (success)
                SvgPicture.asset("assets/connected.svg")
              else
                SvgPicture.asset(
                  'assets/wearabledevice.svg',
                  width: 100,
                  height: 100,
                ),
              const SizedBox(height: 16),
              Text(
                titleText,
                style: AppTextStyles.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                descText,
                style: AppTextStyles.body2.copyWith(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              if (!connecting && !success)
                GestureDetector(
                  onTap: _initSahha,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepTeal,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    width: double.infinity,
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
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
