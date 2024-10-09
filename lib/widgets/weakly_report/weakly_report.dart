import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universal_html/html.dart' as html;

import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../screens/mainScreenV2/downloadReport/cubit.dart';
import '../../screens/mainScreenV2/downloadReport/state.dart';
import '../../screens/mainScreenV2/downloadWeaklyReportState/cubit.dart';
import '../../screens/mainScreenV2/downloadWeaklyReportState/state.dart';
void _downloadPdfWebFromUrl(String pdfUrl) {
  // Using the AnchorElement to download in the browser
  final anchor = html.AnchorElement(href: pdfUrl)
    ..setAttribute("download", "report.pdf")
    ..click(); // Trigger a download by clicking the link
}

class WeaklyReport extends StatefulWidget {
  const WeaklyReport({super.key});

  @override
  State<WeaklyReport> createState() => _WeaklyReportState();
}

class _WeaklyReportState extends State<WeaklyReport> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        BlocConsumer<DownloadWeaklyReportCubit,
            DownloadWeaklyReportState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is SuccessDownloadWeaklyReportState) {
              return GestureDetector(
                onTap: ()  {
                  _downloadPdfWebFromUrl(state.pdfUrlWeakly);
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
            if (state is LoadingDownloadWeaklyReportState) {
              return const CircularProgressIndicator();
            }
            if (state is ErrorDownloadWeaklyReportState) {
              return Row(
                children: [
                  SvgPicture.asset(
                    "assets/document-download.svg",
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
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
                  // print("test on tab");
                  _downloadPdfWebFromUrl(state.pdfUrl);
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
    );
  }
}
