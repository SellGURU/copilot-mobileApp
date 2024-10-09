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

  SurveyCard(
      {super.key,
      required this.Link,
      required this.imagePath,
      required this.Minutes,
      required this.Questions,
      required this.Title});
  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  @override
  Widget build(BuildContext context) {
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
                      // SvgPicture.asset("assets/Blood-Drops-Positive--Streamline-Ultimate.svg",width: 30,height: 30,),
                      Image.asset(widget.imagePath,
                          width: 35, height: 35, fit: BoxFit.fitWidth),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.Title, style: AppTextStyles.hintMedium),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.help_outline,
                                size: 15,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Text("${widget.Questions} Questions",
                                  style: AppTextStyles.hintSmale),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.timer,
                                size: 15,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Text("${widget.Minutes} Minutes",
                                  style: AppTextStyles.hintSmale),
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
                  Dio _dio = Dio();
                  await _dio.post(Endpoints.add_event, data: {
                    "event_type": "clicked",
                    "event_name": widget.Title
                  });
                  rediractUrl(widget.Link);
                },
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: AppColors.purpleDark,
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
  }

  void rediractUrl(String url) async {
    await launch(url);
  }
}
