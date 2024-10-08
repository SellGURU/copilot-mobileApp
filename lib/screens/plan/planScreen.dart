import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../route/names.dart';
import '../../widgets/gauges.dart';
import '../../widgets/normal-Gauges.dart';
import '../../widgets/totalScoreGauge.dart';
import '../Detailed Plan/detailedPlan.dart';

class HealthPlanScreen extends StatefulWidget {
  @override
  State<HealthPlanScreen> createState() => _HealthPlanScreenState();
}

class _HealthPlanScreenState extends State<HealthPlanScreen> {
  var indexItem = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: size.height*.03, horizontal: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:CrossAxisAlignment.center ,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LDL Cholesterol",
                style: AppTextStyles.title1,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/notificationIcon.svg",
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.purpleDark,
                  ),
                ],
              )

            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(202, 202, 215, 0.2),
                    // spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(4, 0), // changes position of shadow
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 0 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            "All",
                            style: indexItem == 0
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 1 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/weight.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 1
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Nutrition",
                            style: indexItem == 1
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 2 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/dna.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 2
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Activity",
                            style: indexItem == 2
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 3;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 3 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/monitor.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 3
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Mind",
                            style: indexItem == 3
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 4;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 4 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/monitor.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 4
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Sleep",
                            style: indexItem == 4
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    NormalGauges(
                      picAddress: "assets/apple.svg",
                      value: 80,
                      colorGauge: AppColors.greenBorder,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    NormalGauges(
                      picAddress: "assets/mind-pink.svg",
                      value: 40,
                      colorGauge: AppColors.pinkBorder,
                    )
                  ],
                ),
                Container(
                  width: size.width * .5,
                  // height: size.height * .1,
                  child: Totalscoregauge(
                    colorGauge:AppColors.pinkBorder,
                    value: 25,
                  ),
                ),
                Column(
                  children: [
                    NormalGauges(
                      picAddress: "assets/weight-yellow.svg",
                      value: 40,
                      colorGauge: AppColors.redBorder,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    NormalGauges(
                      picAddress: "assets/moon.svg",
                      value: 60,
                      colorGauge: AppColors.blueBorder,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                buildHealthCard(
                  'Level up your aerobic workouts',
                  '5 days per week, 30 minutes minimum',
                  'Vary the duration or intensity ',
                  'assets/gym.png',
                ),
                SizedBox(
                  height: 15,
                ),
                buildHealthCard(
                  'Embrace a Diet Rich in Fiber',
                  'To be consumed about 25gr per days',
                  'Embrace a diet rich in fiber',
                  'assets/gym.png',
                ),
                SizedBox(
                  height: 15,
                ),
                buildHealthCard(
                  'Practice Yoga or Meditation',
                  '5 days per week, 30 minutes minimum',
                  'Practice stress-reduction',
                  'assets/gym.png',
                ),
                SizedBox(
                  height: 15,
                ),
                buildHealthCard(
                  'Sleep of 7-9 Hours per Night',
                  'Ensure adequate sleep of 7-9 hours per night',
                  'Sleep between 7pm and 5am',
                  'assets/gym.png',
                ),
                SizedBox(
                  height: 15,
                ),
                buildHealthCard(
                  'Add Antioxidants to Your Diet',
                  'Include these foods in your diet regularly',
                  'Add antioxidants to your diet',
                  'assets/gym.png',
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHealthCard(
      String title, String subtitle, String description, String imagePath) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context)=>detailedPlan()) ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.solid,
                color: Color.fromRGBO(202, 202, 215, 0.3),
                // spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(4, 0), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.title1,
                  ),
                  const SizedBox(height: 5),
                  Container(
                      child: Text(
                    subtitle,
                    style: AppTextStyles.hint,
                  )),
                  SizedBox(height: 5),
                  Container(
                      child: Text(
                    description,
                    style: AppTextStyles.hintBlack,
                  )),
                  SizedBox(height: 5),
                  Text(
                    'View details',
                    style: TextStyle(color: AppColors.purpleDark),
                  ),
                ],
              ),
              Image.asset(imagePath, width: 80, height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
