import 'package:copilet/constants/endPoints.dart';
import 'package:copilet/screens/login/login.dart';
import 'package:copilet/screens/mainScreenV2/cubit/cubit.dart';
import 'package:copilet/screens/mainScreenV2/cubit/state.dart';
import 'package:copilet/screens/mainScreenV2/downloadReport/state.dart';
import 'package:copilet/screens/mainScreenV2/userinfoCubit/cubit.dart';
import 'package:copilet/screens/mainScreenV2/userinfoCubit/state.dart';
import 'dart:io' as io; // For Android file handling
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:rook_sdk_health_connect/rook_sdk_health_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../utility/changeScreanBloc/PageIndex_Bloc.dart';
import '../../utility/changeScreanBloc/PageIndex_states.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_html/html.dart' as html;
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';
import 'dart:convert';
import 'package:rook_sdk_apple_health/rook_sdk_apple_health.dart';
import 'package:rook_sdk_core/rook_sdk_core.dart'; // For kDebugMode

import 'downloadReport/cubit.dart';

Future<void> downloadAndSavePdf(BuildContext context, String base64Pdf) async {
  // Decode base64 string to bytes
  final bytes = base64Decode(base64Pdf);
  print("test gbv");
  if (kIsWeb) {
    // Web logic for downloading the PDF
    print("test pdf");
    _downloadPdfWeb(bytes);
  } else {
    // Android logic for saving the PDF
    print("test pdf mobile");

    await _downloadPdfAndroid(context, bytes);
  }
}

/// Web: Download the PDF using the browser's download mechanism
void _downloadPdfWeb(Uint8List bytes) {
  // Create a Blob object from the bytes
  final blob = html.Blob([bytes], 'application/pdf');

  // Create a URL for the Blob and set it as the href of an anchor element
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "report.pdf")
    ..click(); // Trigger a download by clicking the link

  // Revoke the object URL to avoid memory leaks
  html.Url.revokeObjectUrl(url);
}

/// Android: Save the PDF file using app-specific storage or SAF (File Picker)
Future<void> _downloadPdfAndroid(BuildContext context, Uint8List bytes) async {
  try {
    // Use File Picker to allow the user to choose a location for saving the file
    String? outputFilePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF',
      fileName: 'report.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (outputFilePath != null) {
      // Create a file and write the bytes
      final file = io.File(outputFilePath);
      await file.writeAsBytes(bytes);

      print('PDF saved at $outputFilePath');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved at $outputFilePath')),
      );
    } else {
      // Handle case where the user cancels the file picker
      print('User canceled the save dialog');
    }
  } catch (e) {
    // Handle any errors that occur during the file saving process
    print('Error saving PDF: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error saving PDF')),
    );
  }
}

class Mainscreenv2 extends StatefulWidget {
  const Mainscreenv2({super.key});

  @override
  State<Mainscreenv2> createState() => _Mainscreenv2State();
}

class _Mainscreenv2State extends State<Mainscreenv2> {
  // Example base64 PDF string (you need to replace this with your actual base64 string)

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.bgScreen,
        body: SafeArea(
          child: BlocBuilder<PageIndexBloc, PageIndexState>(
            builder: (context, state) {
              return Container(
                alignment: Alignment.center,
                height: size.height,
                width: size.width,
                child: Container(
                  width: size.width > 420 ? 420 : size.width,
                  child: Stack(
                    children: [
                      const Overview2(),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return Positioned(
                            bottom: 30,
                            right: 40,
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context).logOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/logout.svg",
                                    width: 30,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Log out",
                                    style: AppTextStyles.hint,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class Overview2 extends StatelessWidget {
  const Overview2({super.key});

  void initialize(BuildContext context) {
    const environment = kDebugMode ? RookEnvironment.sandbox : RookEnvironment.production;

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
    HCRookHealthPermissionsManager.checkHealthConnectAvailability().then((availability) {
      _showSnackbar(context, 'Health Connect available: $availability');
    }).catchError((exception) {
      _showSnackbar(context, 'Error checking Health Connect availability: $exception');
    });
  }

  void checkHealthConnectPermissions(BuildContext context) {
    HCRookHealthPermissionsManager.checkHealthConnectPermissions().then((permissionsGranted) {
      _showSnackbar(context, 'Permissions granted: $permissionsGranted');
    }).catchError((exception) {
      _showSnackbar(context, 'Error checking Health Connect permissions: $exception');
    });
  }

  void requestHealthConnectPermissions(BuildContext context) {
    HCRookHealthPermissionsManager.requestHealthConnectPermissions().then((requestPermissionsStatus) {
      if (requestPermissionsStatus == RequestPermissionsStatus.alreadyGranted) {
        _showSnackbar(context, 'Permissions already granted');
      } else {
        _showSnackbar(context, 'Permissions requested, waiting for result');
      }
    }).catchError((error) {
      _showSnackbar(context, 'Error requesting Health Connect permissions: $error');
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // void initializeRook() async {
  //   const environment =
  //       kDebugMode ? RookEnvironment.sandbox : RookEnvironment.production;
  //
  //   final rookConfiguration = RookConfiguration(
  //     clientUUID: "b0eb1473-44ed-4c93-8d90-eb15deb20bb7",
  //     secretKey: "FFybi3eZefYV8ZMhLOeAuT8724oO3ybMkgdR",
  //     environment: environment,
  //     enableBackgroundSync: true,
  //   );
  //
  //   // Enable native logs in debug mode
  //   if (kDebugMode) {
  //     AHRookConfigurationManager.enableNativeLogs();
  //   }
  //
  //   // Set up Rook configuration
  //   AHRookConfigurationManager.setConfiguration(rookConfiguration);
  //
  //   // Initialize the SDK
  //   AHRookConfigurationManager.initRook().then((_) {
  //     print('Rook SDK Initialized');
  //     updateUserID("amin9@gmail.com");
  //   }).catchError((error) {
  //     print('Failed to initialize Rook SDK: $error');
  //   });
  // }
  //
  // void updateUserID(String NewUserID) {
  //   AHRookConfigurationManager.getUserID().then((userID) {
  //     if (userID != null) {
  //       print(userID);
  //       requestPermissions();
  //     } else {
  //       AHRookConfigurationManager.updateUserID(NewUserID).then((_) {
  //         print('User ID updated');
  //       }).catchError((error) {
  //         print('Error updating User ID: $error');
  //       });
  //     }
  //   });
  // }
  //
  // void requestPermissions() {
  //   AHRookHealthPermissionsManager.requestPermissions().then((_) {
  //     print('Permissions granted');
  //   }).catchError((error) {
  //     print('Failed to request permissions: $error');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
        backgroundColor: AppColors.bgScreen,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/avatar.svg",
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            textDirection: TextDirection.ltr,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good morning",
                                style: AppTextStyles.hint,
                              ),
                              BlocConsumer<ClientInformationMobileCubit,
                                  ClientInformationMobileState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  if (state is SuccessClientInformation) {
                                    return Text(
                                      state.userInfo["name"],
                                      style: AppTextStyles.title1,
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/document-download.svg",
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.purpleLite,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Weekly Report",
                                style: AppTextStyles.hintLitePurple,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BlocConsumer<DownloadReportPdfCubit,
                              DownloadPdfState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is SuccessDownloadPdf) {
                                return GestureDetector(
                                  onTap: () async {
                                    print("test on tab");
                                    await downloadAndSavePdf(
                                        context, state.pdfUrl);
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/document-download.svg",
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.purpleLite,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Report",
                                        style: AppTextStyles.hintPurple,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              if (state is LoadingDownloadPdf) {
                                return const CircularProgressIndicator();
                              }
                              if (state is ErrorDownloadPdf) {
                                return Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/document-download.svg",
                                      width: 16,
                                      height: 16,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.purpleLite,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Report",
                                      style: AppTextStyles.hintLitePurple,
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Longevity2(),
                Container(
                  padding: const EdgeInsets.only(top: 1, bottom: 10),
                  height: size.height * .2,
                  // decoration: BoxDecoration(
                  //     border: Border.all(width: 20)
                  // ),
                  child: SvgPicture.asset(
                    "assets/Group20.svg",
                    width: size.width,
                  ),
                ),
                // GestureDetector(
                //   onTap: () =>
                //       _launchURL(
                //           'https://connections.rook-connect.com/client_uuid/d2c34b45-51ff-4ef0-95dc-d87c39136469/user_id/aUniqueUserIdABCD1234/'),
                //   child: const Text("click to request"),
                // ),
                GestureDetector(
                  onTap: ()=>initialize(context),
                  child: const Text("init"),
                ),
                GestureDetector(
                  onTap: ()=>requestHealthConnectPermissions(context),
                  child: const Text("permission"),
                ),
                GestureDetector(
                  onTap: ()=>attemptToEnableYesterdaySync(context),
                  child: const Text("attemptToEnableYesterdaySync"),
                ),
                FocusDetector(
                  onFocusGained: ()=>attemptToEnableYesterdaySync(context),
                  child: const Column(
                    children: [
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
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
      final userAcceptedYesterdaySync = prefs.getBool("ACCEPTED_YESTERDAY_SYNC") ?? false;
      const environment = kDebugMode ? RookEnvironment.sandbox : RookEnvironment.production;

      requestAndroidPermissions(context);

      // Create the configuration for Rook
      if (userAcceptedYesterdaySync) {
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
      final requestPermissionsStatus = await HCRookHealthPermissionsManager.requestAndroidPermissions();

      if (requestPermissionsStatus == RequestPermissionsStatus.alreadyGranted) {
        _showSnackbar(context, "Permissions already granted");
      } else {
        _showSnackbar(context, "Permissions requested, waiting for result");
      }
    } catch (error) {
      _showSnackbar(context, 'Error requesting Android permissions: $error');
    }
  }

}
class Longevity2 extends StatefulWidget {
  const Longevity2({super.key});

  @override
  State<Longevity2> createState() => _Longevity2State();
}

class _Longevity2State extends State<Longevity2> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HealthScoreCubit, HealthScoreState>(
      listener: (BuildContext context, HealthScoreState state) {
        if (state is ErrorHealthScore) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Error in server")));
        }
      },
      builder: (context, HealthScoreState state) {
        if (state is SuccessHealthScore) {
          print("SuccessHealthScore: ${(state).scoreData}");
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Score",
                    style: AppTextStyles.title1,
                  )),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                3, 0), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/human-body-silhouette-with-focus-on-respiratory-system-svgrepo-com 1.svg",
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Center(
                                  child: Text(
                                "Physiological",
                                style: AppTextStyles.title2,
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Your Score",
                                style: AppTextStyles.hintSmale,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(6, 199, 141, .4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, top: 5, left: 12, right: 12),
                                  child: Text(
                                    "${state.scoreData['Physiological'] == null ? 0 : state.scoreData['Physiological']}/100",
                                    style: AppTextStyles.gradeGreen,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              // const Icon(
                              //   Icons.arrow_forward_ios_outlined,
                              //   color: AppColors.textLite,
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/activityIcon.svg",
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(
                                  AppColors
                                      .purpleDark, // The color you want to apply
                                  BlendMode
                                      .srcIn, // Blend mode to apply the color
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Center(
                                  child: Text(
                                "Activity",
                                style: AppTextStyles.title2,
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Your Score",
                                style: AppTextStyles.hintSmale,
                              ),
                              const SizedBox(
                                width: 5,
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(6, 199, 141, .4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, top: 5, left: 12, right: 12),
                                  child: Text(
                                    "${state.scoreData['Fitness'] == null ? 0 : state.scoreData['Fitness']}/100",
                                    style: AppTextStyles.gradeGreen,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              // const Icon(
                              //   Icons.arrow_forward_ios_outlined,
                              //   color: AppColors.textLite,
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/mid.svg",
                                width: 30,
                                height: 30,
                                colorFilter: const ColorFilter.mode(
                                  AppColors
                                      .purpleDark, // The color you want to apply
                                  BlendMode
                                      .srcIn, // Blend mode to apply the color
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Center(
                                  child: Text(
                                "Mind",
                                style: AppTextStyles.title2,
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Your Score",
                                style: AppTextStyles.hintSmale,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.yellowBega.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, top: 5, left: 12, right: 12),
                                  child: Text(
                                    "${state.scoreData['Emotional'] == null ? 0 : state.scoreData['Emotional']}/100",
                                    style: AppTextStyles.gradeYellow,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              // const Icon(
                              //   Icons.arrow_forward_ios_outlined,
                              //   color: AppColors.textLite,
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
