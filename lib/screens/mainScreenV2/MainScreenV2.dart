import 'package:copilet/constants/endPoints.dart';
import 'package:copilet/screens/mainScreenV2/cubit/cubit.dart';
import 'package:copilet/screens/mainScreenV2/cubit/state.dart';
import 'package:copilet/screens/mainScreenV2/downloadReport/state.dart';
import 'dart:io' as io; // For Android file handling
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../utility/changeScreanBloc/PageIndex_Bloc.dart';
import '../../utility/changeScreanBloc/PageIndex_states.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universal_html/html.dart' as html;
import '../login/cubit/cubit.dart';
import '../login/cubit/state.dart';
import 'dart:convert';

import 'downloadReport/cubit.dart';

Future<void> downloadAndSavePdf(BuildContext context, String base64Pdf) async {
  // Decode base64 string to bytes
  final bytes = base64Decode(base64Pdf);

  if (kIsWeb) {
    // Web logic for downloading the PDF
    _downloadPdfWeb(bytes);
  } else {
    // Android logic for saving the PDF
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          children: [
                            Text(
                              "Good morning",
                              style: AppTextStyles.hint,
                            ),
                            Text(
                              "Alexander",
                              style: AppTextStyles.title1,
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
                            }
                            else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Longevity2(),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: SvgPicture.asset(
                    "assets/Group20.svg",
                    width: size.width,
                  ),
                ),
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
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(6, 199, 141, .4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, top: 5, left: 12, right: 12),
                                  child: Text(
                                    "${state.scoreData['Physiological']==null?0:state.scoreData['Physiological']}/100",
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
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(6, 199, 141, .4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, top: 5, left: 12, right: 12),
                                  child: Text(
                                    "${state.scoreData['Fitness']==null?0:state.scoreData['Fitness']}/100",
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
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.yellowBega.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, top: 5, left: 12, right: 12),
                                  child: Text(
                                    "${state.scoreData['Emotional']==null?0:state.scoreData['Emotional']}/100",
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
