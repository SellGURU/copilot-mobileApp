import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rook_sdk_core/rook_sdk_core.dart';
import 'package:rook_sdk_health_connect/rook_sdk_health_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:rook_sdk_health_connect/rook_sdk_health_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rook_sdk_apple_health/rook_sdk_apple_health.dart';
import 'package:rook_sdk_core/rook_sdk_core.dart'; // For kDebugMode

class Permishenhandlerhealth extends StatefulWidget {
  const Permishenhandlerhealth({super.key});

  @override
  State<Permishenhandlerhealth> createState() => _PermishenhandlerhealthState();
}

class _PermishenhandlerhealthState extends State<Permishenhandlerhealth> {

  void initialize(BuildContext context) {
    const environment =
        kDebugMode ? RookEnvironment.sandbox : RookEnvironment.production;

    final rookConfiguration = RookConfiguration(
      clientUUID: "b0eb1473-44ed-4c93-8d90-eb15deb20bb7",
      secretKey: "FFybi3eZefYV8ZMhLOeAuT8724oO3ybMkgdR",
      environment: environment,
      enableBackgroundSync: true,
    );

    if (kDebugMode) {
      HCRookConfigurationManager.enableNativeLogs();
    }

    HCRookConfigurationManager.setConfiguration(rookConfiguration);

    HCRookConfigurationManager.initRook().then((_) {
      _showSnackbar(context, 'Rook initialized successfully');
      updateUserID(context, "amir12@gmail.com");
      checkAvailability(context);
      checkHealthConnectPermissions(context);

    }).catchError((exception) {
      _showSnackbar(context, 'Error during Rook initialization: $exception');
    });
  }

  void updateUserID(BuildContext context, String userID) {
    HCRookConfigurationManager.updateUserID(userID).then((_) {
      _showSnackbar(context, 'UserID updated successfully');
    }).catchError((exception) {
      _showSnackbar(context, 'Error updating UserID: $exception');
    });
  }

  void checkAvailability(BuildContext context) {
    HCRookHealthPermissionsManager.checkHealthConnectAvailability()
        .then((availability) {
      _showSnackbar(context, 'Health Connect available: $availability');
    }).catchError((exception) {
      _showSnackbar(
          context, 'Error checking Health Connect availability: $exception');
    });
  }

  void checkHealthConnectPermissions(BuildContext context) {
    HCRookHealthPermissionsManager.checkHealthConnectPermissions()
        .then((permissionsGranted) {
      _showSnackbar(context, 'Permissions granted: $permissionsGranted');
      if(!permissionsGranted){
        requestHealthConnectPermissions(context);
      }
      else{
        attemptToEnableYesterdaySync(context);
      }
    }).catchError((exception) {
      _showSnackbar(
          context, 'Error checking Health Connect permissions: $exception');
    });
  }

  void requestHealthConnectPermissions(BuildContext context) {
    HCRookHealthPermissionsManager.requestHealthConnectPermissions()
        .then((requestPermissionsStatus) {
      if (requestPermissionsStatus == RequestPermissionsStatus.alreadyGranted) {
        _showSnackbar(context, 'Permissions already granted');
      } else {
        _showSnackbar(context, 'Permissions requested, waiting for result');
      }
    }).catchError((error) {
      _showSnackbar(
          context, 'Error requesting Health Connect permissions: $error');
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _launchURL(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw '$url';
    }
  }

  void attemptToEnableYesterdaySync(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      final userAcceptedYesterdaySync =
          prefs.getBool("ACCEPTED_YESTERDAY_SYNC") ?? false;
      const environment =
          kDebugMode ? RookEnvironment.sandbox : RookEnvironment.production;

      requestAndroidPermissions(context);

      // Create the configuration for Rook
      if (true) {
        _showSnackbar(context, "Yesterday sync enabled");
        HCRookYesterdaySyncManager.scheduleYesterdaySync(
          enableNativeLogs: true,
          clientUUID: "b0eb1473-44ed-4c93-8d90-eb15deb20bb7",
          secretKey: "FFybi3eZefYV8ZMhLOeAuT8724oO3ybMkgdR",
          environment: environment,
        );
      } else {
        _showSnackbar(context, "User has not accepted yesterday sync");
        // The user did not accept the yesterday sync feature
      }
    }).catchError((error) {
      _showSnackbar(context, 'Error accessing SharedPreferences: $error');
    });
  }

  void requestAndroidPermissions(BuildContext context) async {
    try {
      final requestPermissionsStatus =
          await HCRookHealthPermissionsManager.requestAndroidPermissions();

      if (requestPermissionsStatus == RequestPermissionsStatus.alreadyGranted) {
        _showSnackbar(context, "Permissions already granted");
      } else {
        _showSnackbar(context, "Permissions requested, waiting for result");
      }
    } catch (error) {
      _showSnackbar(context, 'Error requesting Android permissions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (false) {
            _launchURL(
                'https://connections.rook-connect.review/client_uuid/d2c34b45-51ff-4ef0-95dc-d87c39136469/user_id/aUniqueUserIdABCD1234/');
          } else {
            initialize(context);
          }
        },
        child: const Text("init the device"),
      ),
    );
  }
}
//GestureDetector(
//                   onTap: () =>
//                       _launchURL(
//                           'https://connections.rook-connect.review/client_uuid/d2c34b45-51ff-4ef0-95dc-d87c39136469/user_id/aUniqueUserIdABCD1234/'),
//                   child: const Text("click to request"),
//                 ),
//                 GestureDetector(
//                   onTap: ()=>initialize(context),
//                   child: const Text("init"),
//                 ),
//                 GestureDetector(
//                   onTap: ()=>checkAvailability(context),
//                   child: const Text("checkAvailability"),
//                 ),
//                 GestureDetector(
//                   onTap: ()=>requestHealthConnectPermissions(context),
//                   child: const Text("permission"),
//                 ),
//                 GestureDetector(
//                   onTap: ()=>attemptToEnableYesterdaySync(context),
//                   child: const Text("attemptToEnableYesterdaySync"),
//                 ),
