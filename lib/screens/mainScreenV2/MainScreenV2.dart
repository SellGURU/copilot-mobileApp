import 'package:copilet/screens/login/login.dart';
import 'package:copilet/screens/mainScreenV2/cubit/cubit.dart';
import 'package:copilet/screens/mainScreenV2/cubit/state.dart';
import 'package:copilet/screens/mainScreenV2/downloadReport/state.dart';
import 'package:copilet/screens/mainScreenV2/downloadWeaklyReportState/cubit.dart';
import 'package:copilet/screens/mainScreenV2/downloadWeaklyReportState/state.dart';
import 'package:copilet/screens/mainScreenV2/userinfoCubit/cubit.dart';
import 'package:copilet/screens/mainScreenV2/userinfoCubit/state.dart';
import 'package:copilet/widgets/SurveysCard/SurveysCard.dart';
import 'package:copilet/widgets/SurveysCard/googleForm/cubit.dart';
import 'package:copilet/widgets/SurveysCard/googleForm/state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async'; // For Timer

import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../utility/changeScreanBloc/PageIndex_Bloc.dart';
import '../../utility/changeScreanBloc/PageIndex_states.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Wearable Device/WearableDevice.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io' as io; // For Android file handling
import 'package:http/http.dart' as http;

import 'downloadReport/cubit.dart';

// Future<void> downloadAndSavePdf(BuildContext context, String base64Pdf) async {
//   // Decode base64 string to bytes
//   final bytes = base64Decode(base64Pdf);
//   print("test gbv");
//   if (kIsWeb) {
//     // Web logic for downloading the PDF
//     print("test pdf");
//     _downloadPdfWeb(bytes);
//   } else {
//     // Android logic for saving the PDF
//     print("test pdf mobile");
//
//     await _downloadPdfAndroid(context, bytes);
//   }
// }
//
// /// Web: Download the PDF using the browser's download mechanism
// void _downloadPdfWeb(Uint8List bytes) {
//   // Create a Blob object from the bytes
//   final blob = html.Blob([bytes], 'application/pdf');
//
//   // Create a URL for the Blob and set it as the href of an anchor element
//   final url = html.Url.createObjectUrlFromBlob(blob);
//   final anchor = html.AnchorElement(href: url)
//     ..setAttribute("download", "report.pdf")
//     ..click(); // Trigger a download by clicking the link
//
//   // Revoke the object URL to avoid memory leaks
//   html.Url.revokeObjectUrl(url);
// }
void _launchURL(String url) async {
  final Uri urlRedirect = Uri.parse(url);
  await launchUrl(urlRedirect);
}

Future<void> downloadPdf(BuildContext context, String pdfUrl) async {
  if (kIsWeb) {
    // Web: Trigger download via browser
    print("test is web");
    _downloadPdfWebFromUrl(pdfUrl);
  } else {
    // Android: Download the file and save it via file picker
    await _downloadPdfAndroidFromUrl(context, pdfUrl);
  }
}

/// Web: Download the PDF using the browser's download mechanism from URL
void _downloadPdfWebFromUrl(String pdfUrl) {
  // Using the AnchorElement to download in the browser
  final anchor = html.AnchorElement(href: pdfUrl)
    ..setAttribute("download", "report.pdf")
    ..click(); // Trigger a download by clicking the link
}

/// Android: Download the PDF from a URL and save it using app-specific storage or SAF (File Picker)
Future<void> _downloadPdfAndroidFromUrl(
    BuildContext context, String pdfUrl) async {
  try {
    // Send an HTTP request to get the PDF file from the URL
    final response = await http.get(Uri.parse(pdfUrl));

    if (response.statusCode == 200) {
      // Use File Picker to allow the user to choose a location for saving the file
      String? outputFilePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save PDF',
        fileName: 'report.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (outputFilePath != null) {
        // Create a file and write the bytes to it
        final file = io.File(outputFilePath);
        await file.writeAsBytes(response.bodyBytes);

        print('PDF saved at $outputFilePath');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF saved at $outputFilePath')),
        );
      } else {
        // Handle case where the user cancels the file picker
        print('User canceled the save dialog');
      }
    } else {
      // Handle the case where the file could not be downloaded
      print('Failed to download PDF: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download PDF')),
      );
    }
  } catch (e) {
    // Handle any errors that occur during the file downloading and saving process
    print('Error downloading or saving PDF: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error downloading or saving PDF')),
    );
  }
}

class Mainscreenv2 extends StatefulWidget {
  const Mainscreenv2({super.key});

  @override
  State<Mainscreenv2> createState() => _Mainscreenv2State();
}

class _Mainscreenv2State extends State<Mainscreenv2> {
  void toggleDropDown() {
    setState(() {
      isShowDropDown = !isShowDropDown;
    });
  }

  // Example base64 PDF string (you need to replace this with your actual base64 string)
  bool isShowDropDown = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SharedPreferences _prefs;
    return Scaffold(
        backgroundColor: AppColors.bgScreen,
        body: SafeArea(
          child: BlocBuilder<PageIndexBloc, PageIndexState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    if (isShowDropDown) {
                      setState(() {
                        isShowDropDown = false;
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height,
                    width: size.width,
                    child: Container(
                      width: size.width > 420 ? 420 : size.width,
                      child: Stack(
                        children: [
                          Overview2(
                            isShowDropDown: isShowDropDown,
                            onToggleDropDown: toggleDropDown,
                          ),
                          if (isShowDropDown)
                            Positioned(
                                top: 70,
                                left: 50,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  width: 133,
                                  height: 92,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.1),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/watch-status.svg",
                                            width: 30,
                                            height: 16,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () async => {
                                              _prefs = await SharedPreferences
                                                  .getInstance(),

                                              // _launchURL(
                                              //     "https://connections.rook-connect.review/client_uuid/b0eb1473-44ed-4c93-8d90-eb15deb20bb7/user_id/${_prefs.getString("email")}/")
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WearableDevice()),
                                              )
                                            },
                                            child: Text(
                                              "Wearable Device",
                                              style: AppTextStyles
                                                  .hintBlackWithHeight,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, state) {
                                          return GestureDetector(
                                            onTap: () async {
                                              await BlocProvider.of<AuthCubit>(
                                                      context)
                                                  .logOut();
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/logout.svg",
                                                  width: 30,
                                                  height: 16,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black,
                                                      BlendMode.srcIn),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Log out",
                                                  style: AppTextStyles
                                                      .hintBlackWithHeight,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class Overview2 extends StatefulWidget {
  // void initializeRook() async {
  final bool isShowDropDown;
  final Function onToggleDropDown;

  Overview2({
    super.key,
    required this.isShowDropDown,
    required this.onToggleDropDown,
  });

  @override
  State<Overview2> createState() => _Overview2State();
}

class _Overview2State extends State<Overview2> {
  DateTime? _storedTime; // To store the time locally
  String _timePassed = '0'; // To display the time passed
  @override
  void initState() {
    getTime();
  }

  void getTime() async {
    print("_timePassed");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _timePassedCheck =
        prefs.getString('buttonPressTime')!; // To display the time passed
    if (_timePassedCheck != null) {
      print("_timePassed $_timePassedCheck");
      _storedTime = DateTime.parse(_timePassedCheck);
      final difference = DateTime.now().difference(_storedTime!);
      print("time:'${difference.inSeconds} seconds");

      setState(() {
        if (difference.inSeconds < 60) {
          _timePassed = '${difference.inSeconds} seconds';
        } else if (difference.inMinutes < 60) {
          _timePassed = '${difference.inMinutes} minutes';
        } else if (difference.inHours < 24) {
          _timePassed = '${difference.inHours} hours';
        } else {
          _timePassed = '${difference.inDays} days';
        }
      });
    } else {
      setState(() {
        _timePassed = "No time stored.";
      });
    }
  }

  // Store the current time and show time passed automatically
  Future<void> _storeTimeAndShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();

    // Store the current time
    await prefs.setString('buttonPressTime', now.toIso8601String());
    print("Time stored: $now");

    // Calculate and show the time passed immediately
    String? storedTimeStr = prefs.getString('buttonPressTime');

    if (storedTimeStr != null) {
      _storedTime = DateTime.parse(storedTimeStr);
      final difference = DateTime.now().difference(_storedTime!);
      print("time:${difference.inMinutes}");

      setState(() {
        if (difference.inSeconds < 60) {
          _timePassed = "${difference.inSeconds} seconds";
        } else if (difference.inMinutes < 60) {
          _timePassed = "${difference.inMinutes} minutes";
        } else if (difference.inHours < 24) {
          _timePassed = "${difference.inHours} hours";
        } else {
          _timePassed = "${difference.inDays} days";
        }
      });
    } else {
      setState(() {
        _timePassed = "No time stored.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => {widget.onToggleDropDown()},
                            child: SvgPicture.asset(
                              "assets/avatar.svg",
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
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
                                    return GestureDetector(
                                      onTap: () => {widget.onToggleDropDown()},
                                      child: Text(
                                        state.userInfo["name"],
                                        style: AppTextStyles.title1,
                                      ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocConsumer<DownloadWeaklyReportCubit,
                              DownloadWeaklyReportState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state is SuccessDownloadWeaklyReportState) {
                                return GestureDetector(
                                  onTap: () {
                                    _storeTimeAndShow();
                                    _launchURL(state.pdfUrlWeakly);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/document-download.svg",
                                            width: 16,
                                            height: 16,
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.purpleDark,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Weakly Report",
                                            style: AppTextStyles.hintPurple,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Last Generate: $_timePassed ago",
                                        style: AppTextStyles.hintVerySmale,
                                      )
                                    ],
                                  ),
                                );
                              }
                              if (state is LoadingDownloadWeaklyReportState) {
                                return const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator());
                              }
                              if (state is ErrorDownloadWeaklyReportState) {
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
                                      "Weekly Report",
                                      style: AppTextStyles.hintLitePurple,
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          const SizedBox(
                            width: 15,
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
                                    // print("test on tab");
                                    _launchURL(state.pdfUrl);
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/document-download.svg",
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.purpleDark,
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
                                return const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator());
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
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<GoogleFormCubit, GoogleFormState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is SuccessGoogleFormState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Surveys",
                            style: AppTextStyles.title1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SurveyCard(
                            imagePath:
                                'assets/Medical-Specialty-Rehabilitation--Streamline-Ultimate.svg',
                            Minutes: state.googleFormData["Back Pain Surveys"]
                                ["Average_response_time"],
                            Questions: state.googleFormData['Back Pain Surveys']
                                ["number_of_questions"],
                            Title: 'Back Pain Surveys',
                            Link: state.googleFormData['Back Pain Surveys']
                                ["link"],
                            fill: state.googleFormData['Back Pain Surveys']
                                ["filled"],
                          ),
                          SurveyCard(
                            imagePath:
                                'assets/heart-rate-strong--Streamline-Ultimate.svg',
                            Minutes:
                                state.googleFormData["Fitness test results"]
                                    ["Average_response_time"],
                            Questions:
                                state.googleFormData['Fitness test results']
                                    ["number_of_questions"],
                            Title: 'Fitness Test Results',
                            Link: state.googleFormData['Fitness test results']
                                ["link"],
                            fill: state.googleFormData['Fitness test results']
                                ["filled"],
                          ),
                          SurveyCard(
                            imagePath:
                                'assets/herbal-medicine-2--Streamline-Ultimate.svg',
                            Minutes: state.googleFormData[
                                    "Longevity Performance Coaching Daily Survey"]
                                ["Average_response_time"],
                            Questions: state.googleFormData[
                                    'Longevity Performance Coaching Daily Survey']
                                ["number_of_questions"],
                            Title: 'Longevity Performance Coaching',
                            Link: state.googleFormData[
                                    'Longevity Performance Coaching Daily Survey']
                                ["link"],
                            fill: state.googleFormData[
                                    'Longevity Performance Coaching Daily Survey']
                                ["filled"],
                          ),
                          SurveyCard(
                            imagePath:
                                'assets/brain-head-1--Streamline-Ultimate.svg',
                            Minutes: state.googleFormData[
                                    "Emotional Health and Motivation Survey"]
                                ["Average_response_time"],
                            Questions: state.googleFormData[
                                    'Emotional Health and Motivation Survey']
                                ["number_of_questions"],
                            Title: 'Emotional Health and Motivation',
                            Link: state.googleFormData[
                                    'Emotional Health and Motivation Survey']
                                ["link"],
                            fill: state.googleFormData[
                                    'Emotional Health and Motivation Survey']
                                ["filled"],
                          ),
                          SurveyCard(
                            imagePath:
                                'assets/heart-approve-1--Streamline-Ultimate.svg',
                            Minutes: state.googleFormData[
                                    "Stability, Mobility and Flexibility tests"]
                                ["Average_response_time"],
                            Questions: state.googleFormData[
                                    'Stability, Mobility and Flexibility tests']
                                ["number_of_questions"],
                            Title: 'Stability, Mobility and Flexibility',
                            Link: state.googleFormData[
                                    'Stability, Mobility and Flexibility tests']
                                ["link"],
                            fill: state.googleFormData[
                                    'Stability, Mobility and Flexibility tests']
                                ["filled"],
                          ),
                          SurveyCard(
                            imagePath:
                                'assets/Blood-Drops-Positive--Streamline-Ultimate.svg',
                            Minutes: state.googleFormData["Blood test"]
                                ["Average_response_time"],
                            Questions: state.googleFormData['Blood test']
                                ["number_of_questions"],
                            Title: 'Blood Test',
                            Link: state.googleFormData['Blood test']["link"],
                            fill: state.googleFormData['Blood test']["filled"],
                          ),
                          SurveyCard(
                            imagePath:
                                'assets/Medical-Data-Cross--Streamline-Ultimate.svg',
                            Minutes: state.googleFormData["Clinet info"]
                                ["Average_response_time"],
                            Questions: state.googleFormData['Clinet info']
                                ["number_of_questions"],
                            Title: 'Clinet info',
                            Link: state.googleFormData['Clinet info']["link"],
                            fill: state.googleFormData['Clinet info']["filled"],
                          ),
                        ],
                      );
                    }
                    if (state is LoadingGoogleFormState) {
                      return const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator());
                    } else {
                      return const Text("have error");
                    }
                  },
                )
                // Container(
                //   padding: const EdgeInsets.only(top: 1, bottom: 10),
                //   height: size.height * .2,
                //   // decoration: BoxDecoration(
                //   //     border: Border.all(width: 20)
                //   // ),
                //   child: SvgPicture.asset(
                //     "assets/Group20.svg",
                //     width: size.width,
                //   ),
                // ),
              ],
            ),
          ),
        ));
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
          // print("SuccessHealthScore: ${(state).scoreData}");
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
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(153, 171, 198, 0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/human-body-silhouette-with-focus-on-respiratory-system-svgrepo-com 1.svg",
                                width: 30,
                                height: 25,
                              ),
                              SizedBox(
                                width: 2,
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
                                "Your Score:",
                                style: AppTextStyles.hintSmale,
                              ),
                              // rgba(245, 222, 222, 1)

                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(201, 235, 237, 1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 5, left: 12, right: 12),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${state.scoreData['Physiological'] == null ? 0 : state.scoreData['Physiological']}",
                                          style: AppTextStyles.titleSmaleBold,
                                        ),
                                        Text(
                                          "/100",
                                          style: AppTextStyles.hintSmale,
                                        ),
                                      ],
                                    )),
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
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(153, 171, 198, 0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4), // changes position of shadow
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
                                width: 20,
                                height: 20,
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
                                "Fitness",
                                style: AppTextStyles.title2,
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Your Score:",
                                style: AppTextStyles.hintSmale,
                              ),
                              const SizedBox(
                                width: 5,
                              ),

                              Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(201, 235, 237, 1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5,
                                          top: 5,
                                          left: 12,
                                          right: 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${state.scoreData['Fitness'] == null ? 0 : state.scoreData['Fitness']}",
                                            style: AppTextStyles.titleSmaleBold,
                                          ),
                                          Text(
                                            "/100",
                                            style: AppTextStyles.hintSmale,
                                          ),
                                        ],
                                      ))),
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
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(153, 171, 198, 0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4), // changes position of shadow
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
                                width: 17,
                                height: 17,
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
                                "Emotional",
                                style: AppTextStyles.title2,
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Your Score:",
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
                                    child: Row(
                                      children: [
                                        Text(
                                          "${state.scoreData['Emotional'] == null ? 0 : state.scoreData['Emotional']}",
                                          style: AppTextStyles.titleSmaleBold,
                                        ),
                                        Text(
                                          "/100",
                                          style: AppTextStyles.hintSmale,
                                        ),
                                      ],
                                    )),
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
