import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';

import '../components/text_style.dart';
import '../res/colors.dart';
import '../constants/endPoints.dart';
import '../utility/token/getTokenLocaly.dart';

class Longevity extends StatefulWidget {
  const Longevity({super.key});

  @override
  State<Longevity> createState() => _LongevityState();
}

class _LongevityState extends State<Longevity> {
  double dietScore = 0;
  double mindScore = 0;
  double activityScore = 0;
  double supplementScore = 0;
  double lifestyle =0;
  bool isLoading = true;
  String? error;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    getScores();
  }

  Future<void> getScores() async {
    try {
      var token = await getTokenLocally();
      _dio.options.headers['Authorization'] = "bearer $token";

      final response = await _dio.post(Endpoints.getScores);

      if (response.statusCode == 200) {
        final data = response.data["scores"];
        print(data);
        setState(() {
          dietScore = data['diet'] ?? 0;
          mindScore = data['lifestyle'] ?? 0;
          activityScore = data['activity'] ?? 0;
          supplementScore = data['supplement'] ?? 0;
          lifestyle = data['lifestyle'] ?? 0;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load scores';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching scores: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text(error!));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Container(alignment: Alignment.centerLeft,child: Text("Longevity Theme",style: AppTextStyles.title1,)),
        const SizedBox(height: 10,),
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
                      offset: const Offset(3, 0),
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
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/diet.svg",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
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
                          decoration: BoxDecoration(
                            color: dietScore >= 70 ? AppColors.greenLite : AppColors.redLite,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  dietScore.toString(),
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 13,),
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
                      offset: const Offset(0, 2),
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
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/lifeStyle.svg",
                              width: 16,
                              height: 16,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),                        
                        const SizedBox(width: 5,),
                        Center(
                            child: Text(
                          "Lifestyle",
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
                          decoration: BoxDecoration(
                            color: mindScore >= 70 ? AppColors.greenLite : AppColors.redLite,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  lifestyle.toString(),
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 13,),
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
                      offset: const Offset(0, 2),
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
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/weight.svg",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
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
                          decoration: BoxDecoration(
                            color: activityScore >= 70 ? AppColors.greenLite : AppColors.redLite,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  activityScore.toString(),
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 13,),
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
                      offset: const Offset(0, 2),
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
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:Center(
                            child:SvgPicture.asset(
                              "assets/pil.svg",
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),                        
                        const SizedBox(width: 5,),
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
                          decoration: BoxDecoration(
                            color: supplementScore >= 70 ? AppColors.greenLite : AppColors.redLite,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Row(
                              children: [
                                Text(
                                  supplementScore.toString(),
                                  style: AppTextStyles.titleSmaleBold,
                                ),
                                Text(
                                  "/100",
                                  style: AppTextStyles.hintSmale,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 13,),
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
