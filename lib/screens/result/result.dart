import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_copilet/components/text_style.dart';

import '../../res/colors.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var indexItem = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Results",
                style: AppTextStyles.title1,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.purpleDark,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    "assets/notificationIcon.svg",
                    width: 25,
                    height: 25,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem ==0;
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color:AppColors.purpleDark,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                      child: Row(

                        children: [
                          SvgPicture.asset(
                            "assets/apple.svg",
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Blood",
                            style: AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem ==1;
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color:AppColors.purpleDark,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                      child: Row(

                        children: [
                          SvgPicture.asset(
                            "assets/apple.svg",
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Blood",
                            style: AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem ==2;
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color:AppColors.purpleDark,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                      child: Row(

                        children: [
                          SvgPicture.asset(
                            "assets/apple.svg",
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Blood",
                            style: AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem ==3;
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color:AppColors.purpleDark,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                      child: Row(

                        children: [
                          SvgPicture.asset(
                            "assets/apple.svg",
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Blood",
                            style: AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
