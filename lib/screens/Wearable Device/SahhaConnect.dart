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
  }

  Future<void> _initSahha() async {
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
        externalId: "SampleProfile-2a4b389b-0b0a-43d3-bbfc-990f7e0acf15",
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
                  log.contains("ready") || log.contains("enabled")
                      ? Icons.check_circle
                      : Icons.error,
                  size: 64,
                  color: log.contains("ready") || log.contains("enabled")
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
                child: const Text("Connect"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
