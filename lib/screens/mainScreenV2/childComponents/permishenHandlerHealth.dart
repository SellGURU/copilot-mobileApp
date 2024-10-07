
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rook_sdk_core/rook_sdk_core.dart';
import 'package:rook_sdk_health_connect/rook_sdk_health_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:focus_detector_v2/focus_detector_v2.dart';
// import 'package:rook_sdk_health_connect/rook_sdk_health_connect.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:rook_sdk_apple_health/rook_sdk_apple_health.dart';
// import 'package:rook_sdk_core/rook_sdk_core.dart'; // For kDebugMode

class Permishenhandlerhealth extends StatefulWidget {
  const Permishenhandlerhealth({super.key});

  @override
  State<Permishenhandlerhealth> createState() => _PermishenhandlerhealthState();
}

class _PermishenhandlerhealthState extends State<Permishenhandlerhealth> {
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

  @override
  void initState() {
    super.initState();
    // initialize(context);
    requestAndroidPermissions(context);
  }

  void initialize(BuildContext context)async {

    // const environment =
    //     kDebugMode ? RookEnvironment.sandbox : RookEnvironment.production;
    // const environment = ;
    final rookConfiguration = RookConfiguration(
      clientUUID: "b0eb1473-44ed-4c93-8d90-eb15deb20bb7",
      secretKey: "FFybi3eZefYV8ZMhLOeAuT8724oO3ybMkgdR",
      environment: RookEnvironment.sandbox,
      enableBackgroundSync: true,
    );

    if (kDebugMode) {
      HCRookConfigurationManager.enableNativeLogs();
    }

    HCRookConfigurationManager.setConfiguration(rookConfiguration);
    var checkVisibleAccount = checkUserIDRegistered();
    if (checkVisibleAccount) {
      HCRookConfigurationManager.initRook().then((_) {
        _showSnackbar(context, 'Rook initialized successfully');
        updateUserID(context, "amir12@gmail.com");
        var permissionAndroid = checkAndroidPermissions();
        if (permissionAndroid) requestAndroidPermissions(context);
        if (checkAvailability(context) == HCAvailabilityStatus.installed) {
          checkHealthConnectPermissions(context);
          attemptToEnableYesterdaySync(context);
        }
      }).catchError((exception) {
        _showSnackbar(context, 'Error during Rook initialization: $exception');
      });
    } else {
      var permissionAndroid = checkAndroidPermissions();
      if (!permissionAndroid) requestAndroidPermissions(context);
      var checkAvailabilityHealthApp = await checkAvailability(context);
      print("checkAvailabilityHealthApp: $checkAvailabilityHealthApp");

      if (checkAvailabilityHealthApp == HCAvailabilityStatus.installed) {
        checkHealthConnectPermissions(context);
        attemptToEnableYesterdaySync(context);
      }
    }
  }

  // if user not register
  void updateUserID(BuildContext context, String userID) {
    HCRookConfigurationManager.updateUserID(userID).then((_) {
      _showSnackbar(context, 'UserID updated successfully');
    }).catchError((exception) {
      _showSnackbar(context, 'Error updating UserID: $exception');
    });
  }

  //
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

  // fetch the health data
  void attemptToEnableYesterdaySync(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      final userAcceptedYesterdaySync =
          prefs.getBool("ACCEPTED_YESTERDAY_SYNC") ?? false;
      // const environment =
      //     kDebugMode ? RookEnvironment.sandbox : RookEnvironment.production;
      // const environment = ;
      // Create the configuration for Rook
      if (true) {
        HCRookYesterdaySyncManager.scheduleYesterdaySync(
          enableNativeLogs: true,
          clientUUID: "b0eb1473-44ed-4c93-8d90-eb15deb20bb7",
          secretKey: "FFybi3eZefYV8ZMhLOeAuT8724oO3ybMkgdR",
          environment: RookEnvironment.sandbox,
        );
        _showSnackbar(context, "Yesterday sync do");
      } else {
        _showSnackbar(context, "User has not accepted yesterday sync");
        // The user did not accept the yesterday sync feature
      }
    }).catchError((error) {
      _showSnackbar(context, 'Error accessing SharedPreferences: $error');
    });
  }

  // if background run is not permit
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

  // check the connect the app to health app or not
  void checkHealthConnectPermissions(BuildContext context) {
    HCRookHealthPermissionsManager.checkHealthConnectPermissions()
        .then((permissionsGranted) {
      _showSnackbar(context, 'Permissions granted: $permissionsGranted');
      requestHealthConnectPermissions(context);
      if (!permissionsGranted) {
        requestHealthConnectPermissions(context);
      }
    }).catchError((exception) {
      _showSnackbar(
          context, 'Error checking Health Connect permissions: $exception');
    });
  }

  // check the health app is install or not
  Future<HCAvailabilityStatus> checkAvailability(BuildContext context) async {
    try {
      HCAvailabilityStatus availability = await HCRookHealthPermissionsManager.checkHealthConnectAvailability();

      if (availability == HCAvailabilityStatus.notInstalled) {
        _launchURL("https://google.com");
      } else if (availability == HCAvailabilityStatus.notSupported) {
        _showSnackbar(context, "Device does not support Health Connect.");
      }

      print("checkAvailabilityHealthApp status: $availability");
      return availability;
    } catch (exception) {
      _showSnackbar(context, 'Error checking Health Connect availability: $exception');
      return HCAvailabilityStatus.notInstalled;  // Return a default status in case of an error
    }
  }


  // check the accesses the data background
  bool checkAndroidPermissions() {
    bool check=false;
    HCRookHealthPermissionsManager.checkAndroidPermissions()
        .then((permissionsGranted) {
      check = permissionsGranted;
    }).catchError((exception) {
      _showSnackbar(context, "error in Permissions android $exception ");
    });
    return check;
  }

  // check user exist
  bool checkUserIDRegistered() {
    HCRookConfigurationManager.getUserID().then((userID) {
      if (userID != null) {
        print(userID);
        return true;
      } else {
        print("user not found");
        return false;
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Center(
            child:
              GestureDetector(
                onTap: () {
                  initialize(context);
                },
                child: const Text("init the device"),
              ),
              // GestureDetector(
              //   onTap: checkUserIDRegistered,
              //   child: Text("checkUserIDRegistered"),
              // ),
              // GestureDetector(
              //   onTap: () => attemptToEnableYesterdaySync(context),
              //   child: Text("attemptToEnableYesterdaySync"),
              // )
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
