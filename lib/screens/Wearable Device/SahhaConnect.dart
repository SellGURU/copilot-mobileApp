import 'package:flutter/material.dart';
import 'package:sahha_flutter/sahha_flutter.dart';

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
    _initSahha();
  }

  Future<void> _initSahha() async {
    // var notificationSettings = {
    //   'icon': 'Custom Icon',
    //   'title': 'Custom Title',
    //   'shortDescription': 'Custom Description'
    // };

    setState(() {
      loading = true;
      log = "Configuring Sahha...";
    });

    try {
      // Configure
      bool configured = await SahhaFlutter.configure(
        environment: SahhaEnvironment.sandbox, // Use .production for live
        // notificationSettings: notificationSettings,
      );

      if (!configured) {
        throw "Sahha configuration failed";
      }

      setState(() {
        log = "Configuration successful! Authenticating...";
      });

      // Authenticate
      bool authSuccess = await SahhaFlutter.authenticate(
        appId: "o6rAnanD0tnm877eT73dV8BQhSvOEC7b",
        appSecret: "ayjYop9i8ZBPt7AFCvtfeLyXKBICFEa99aaCASGOPik4LgeqSQ7nROq0g3HndAOv",
        externalId: "SampleProfile-2a4b389b-0b0a-43d3-bbfc-990f7e0acf15",
      );

      if (!authSuccess) {
        throw "Authentication failed";
      }

      setState(() {
        log = "Authentication successful! Enabling sensors...";
      });

      // Enable sensors
      // bool sensorsEnabled = (await SahhaFlutter.enableSensors(['steps'])) as bool;

      // setState(() {
      //   loading = false;
      //   log = sensorsEnabled
      //       ? "Sensors enabled. Device is ready."
      //       : "Sensors could not be enabled. Please check permissions.";
      // });
    } catch (e) {
      setState(() {
        loading = false;
        log = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wearable Devices")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading)
                const CircularProgressIndicator()
              else
                Icon(
                  log.contains("successful") || log.contains("ready")
                      ? Icons.check_circle
                      : Icons.error,
                  size: 64,
                  color: log.contains("successful") || log.contains("ready")
                      ? Colors.green
                      : Colors.red,
                ),
              const SizedBox(height: 20),
              Text(
                log,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _initSahha,
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
