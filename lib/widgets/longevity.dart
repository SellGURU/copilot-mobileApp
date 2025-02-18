import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/text_style.dart';
import '../res/colors.dart';


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
        const SizedBox(height: 20,),
        Container(alignment: Alignment.centerLeft,child: Text("Longevity Theme",style: AppTextStyles.title1,)),
      const  SizedBox(height: 10,),
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
                      offset: const Offset(3, 0), // changes position of shadow
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
                        Container(
                          width: 32,
                          height:32,
                          // color: Colors.yellowAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1), // Border
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/diet.svg",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(AppColors.PurpleLiteText, BlendMode.srcIn),
                          ),
                          ),
                        ),                        
                        
                        const SizedBox(width: 5,),
                        Center(
                            child: Text(
                          "Diet",
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
                          decoration: BoxDecoration(color: AppColors.greenLite,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  "90",
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                                // Text("${"90"}/100",style: AppTextStyles.gradeGreen,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13,),
                        // SvgPicture.asset("assets/arrowHome.svg")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
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
                        Container(
                          width: 32,
                          height:32,
                          // color: Colors.yellowAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1), // Border
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/mental-disorder.svg",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(AppColors.PurpleLiteText, BlendMode.srcIn),
                          ),
                          ),
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
                          style: AppTextStyles.hint,
                        ),
                        Container(
                          decoration: BoxDecoration(color: AppColors.redLite,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  "56",
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                                // Text("${"56"}/100",style: AppTextStyles.gradeYellow,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13,),
                        // SvgPicture.asset("assets/arrowHome.svg")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
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
                        Container(
                          width: 32,
                          height:32,
                          // color: Colors.yellowAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1), // Border
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/weight.svg",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(AppColors.PurpleLiteText, BlendMode.srcIn),
                          ),
                          ),
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
                          decoration: BoxDecoration(color: AppColors.greenLite,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  "89",
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                                // Text("${"89"}/100",style: AppTextStyles.gradeGreen,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13,),
                        // SvgPicture.asset("assets/arrowHome.svg")
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
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
                        Container(
                          width: 32,
                          height:32,
                          // color: Colors.yellowAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1), // Border
                            borderRadius: BorderRadius.circular(20), // Rounded corners
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/pil.svg",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(AppColors.PurpleLiteText, BlendMode.srcIn),
                          ),
                          ),
                        ),                        
                        
                        SizedBox(width: 5,),
                        Center(
                            child: Text(
                              "Supplement",
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
                          decoration: BoxDecoration(color: AppColors.redLite,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  "29",
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                                // Text("${"29"}/100",style: AppTextStyles.gradeRed,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13,),
                        // SvgPicture.asset("assets/arrowHome.svg")
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
