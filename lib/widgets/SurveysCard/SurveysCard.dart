import 'package:copilet/components/text_style.dart';
import 'package:copilet/constants/endPoints.dart';
import 'package:copilet/res/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utility/LaunchUrl.dart';

class SurveyCard extends StatefulWidget {
  String imagePath;
  int Questions;
  int Minutes;
  String Title;
  String Link;
  bool fill;
  String eventName;

  SurveyCard(
      {super.key,
      required this.fill,
      required this.Link,
      required this.imagePath,
      required this.Minutes,
      required this.Questions,
      required this.eventName,
      required this.Title});
  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  @override
  Widget build(BuildContext context) {
    print("${widget.Title}:${widget.fill}");
    if (!widget.fill) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(153, 171, 198, 0.2),
              spreadRadius: 1,
              blurRadius: 22,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Stack(children: [
          Positioned(
            right: 0,
            child: Image.asset("assets/bg_survey_card.png"),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon and Text
                    Row(
                      children: [
                        SvgPicture.asset(
                          widget.imagePath,
                          width: 35,
                          height: 35,
                        ),
                        // Image.asset(widget.imagePath,
                        //     width: 35, height: 35, fit: BoxFit.fitWidth),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.Title, style: AppTextStyles.hintMedium),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/message-question1.svg"),
                                const SizedBox(width: 5),
                                Text("${widget.Questions} Questions",
                                    style: AppTextStyles.hintSmaleLite),
                                const SizedBox(width: 20),
                                SvgPicture.asset("assets/timer.svg"),
                                const SizedBox(width: 5),
                                Text("${widget.Minutes} Minutes",
                                    style: AppTextStyles.hintSmaleLite),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // Arrow Icon
                GestureDetector(
                  onTap: () async {
                    print("check clicked");
                    Dio _dio = Dio();
                    await _dio.post(Endpoints.add_event, data: {
                      "event_type": "clicked",
                      "event_name": widget.eventName
                    });
                    rediractUrl(widget.Link);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: AppColors.pinkBorder,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/arrow-down.svg",
                        width: 15,
                        height: 15,
                      )),
                ),
              ],
            ),
          ),
        ]),
      );
    } else {
      return const SizedBox();
    }
  }

  void rediractUrl(String url) async {
    final Uri urlRedirect = Uri.parse(url);
    await launchUrl(urlRedirect);
  }
}
