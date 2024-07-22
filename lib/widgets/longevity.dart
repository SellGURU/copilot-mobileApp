import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/components/text_style.dart';
import 'package:test_copilet/res/colors.dart';

class Longevity extends StatefulWidget {
  const Longevity({super.key});

  @override
  State<Longevity> createState() => _LongevityState();
}

class _LongevityState extends State<Longevity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Container(alignment: Alignment.centerLeft,child: Text("Longevity Theme",style: AppTextStyles.title1,)),
        SizedBox(height: 10,),
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
                      offset: const Offset(0, 2), // changes position of shadow
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
                          "assets/apple.svg",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 5,),
                        Center(
                            child: Text(
                          "Nutrition",
                          style: AppTextStyles.title2,
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Health Score: ",
                          style: AppTextStyles.hint,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Color.fromRGBO(6, 199, 141, .4),borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Text("${"90"}/100",style: AppTextStyles.gradeGreen,),
                          ),
                        ),
                        SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textLite,)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
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
                        ),
                        SizedBox(width: 5,),
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
                          "Health Score: ",
                          style: AppTextStyles.hintSmale,
                        ),
                        Container(
                          decoration: BoxDecoration(color: AppColors.yellowBega,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Text("${"56"}/100",style: AppTextStyles.gradeYellow,),
                          ),
                        ),
                        SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textLite,)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
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
                        ),
                        SizedBox(width: 5,),
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
                          "Health Score: ",
                          style: AppTextStyles.hint,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Color.fromRGBO(6, 199, 141, .4),borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Text("${"89"}/100",style: AppTextStyles.gradeGreen,),
                          ),
                        ),
                        SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textLite,)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
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
                          "assets/sleepIcon.svg",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 5,),
                        Center(
                            child: Text(
                              "Sleep",
                              style: AppTextStyles.title2,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Health Score: ",
                          style: AppTextStyles.hint,
                        ),
                        Container(
                          decoration: BoxDecoration(color: AppColors.redBega,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Text("${"29"}/100",style: AppTextStyles.gradeRed,),
                          ),
                        ),
                        SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textLite,)
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
  }
}
