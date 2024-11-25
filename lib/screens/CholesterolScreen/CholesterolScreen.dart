import 'dart:math';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../widgets/accordion.dart';
import '../../widgets/chart.dart';

class CholesterolScreen extends StatefulWidget {
  @override
  String title = "";
  CholesterolScreen({Key? key, required this.title}) : super(key: key);
  State<CholesterolScreen> createState() => _CholesterolScreenState();
}

class _CholesterolScreenState extends State<CholesterolScreen> {
  var indexItem = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.bgScreen, actions: [
        Text(
          "",
          style: AppTextStyles.title1,
        ),
        SizedBox(
          width: size.width * .40,
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
            const SizedBox(
              width: 15,
            ),
          ],
        )
      ]),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header tabs
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 1), // changes position of shadow
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
                            color: indexItem == 0
                                ? AppColors.purpleDark
                                : Colors.white,
                          ),
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.height * 0.02, vertical: 8),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/drops.svg",
                                    colorFilter: ColorFilter.mode(
                                        indexItem == 0
                                            ? AppColors.mainBg
                                            : AppColors.textLite,
                                        BlendMode.srcIn)),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Result",
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
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: indexItem == 1
                                ? AppColors.purpleDark
                                : Colors.white,
                          ),
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.height * 0.02, vertical: 8),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/message-question.svg",
                                    colorFilter: ColorFilter.mode(
                                        indexItem == 1
                                            ? AppColors.mainBg
                                            : AppColors.textLite,
                                        BlendMode.srcIn)),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "How to improve",
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
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: indexItem == 2
                                ? AppColors.purpleDark
                                : Colors.white,
                          ),
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.height * 0.02, vertical: 8),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/lamp-on.svg",
                                    colorFilter: ColorFilter.mode(
                                        indexItem == 2
                                            ? AppColors.mainBg
                                            : AppColors.textLite,
                                        BlendMode.srcIn)),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "Insight",
                                  style: indexItem == 2
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
                ), // Latest and History buttons
                const SizedBox(
                  height: 15,
                ),
                IndexedStack(
                  index: indexItem,
                  children: [
                    ResultMainTab(title: widget.title),
                    HowToImproveTab(
                      title: widget.title,
                    ),
                    InsightTab(
                      title: widget.title,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultMainTab extends StatefulWidget {
  late String title;
  ResultMainTab({super.key, required this.title});

  @override
  State<ResultMainTab> createState() => _ResultMainTabState();
}

class _ResultMainTabState extends State<ResultMainTab> {



  var toggleHistoryMod = "History";
  var sections = [
    {
      'headerText': 'What Borderline LDL Cholesterol means for your health?',
      'contentText': 'Content for the first section.',
    },
    {
      'headerText': 'What you body says',
      'contentText': 'Content for the second section.',
    },
    // Add more sections as needed
  ];
  double nextGaussian() {
    final random = Random();
    double u1 = random.nextDouble();
    double u2 = random.nextDouble();
    return sqrt(-2 * log(u1)) * cos(2 * pi * u2); // Box-Muller transform
  }

  double getRandomY() {
    double mean = 120; // Average heart rate (center of the range)
    double stdDev = 30; // Standard deviation for wider spread
    double randomValue = mean + stdDev * nextGaussian();
    return randomValue.clamp(60, 180); // Clamp values between 60 and 180
  }
  getSpots(){
    var spots=[
      FlSpot(1, getRandomY()),
      FlSpot(2, getRandomY()),
      FlSpot(3, getRandomY()),
      FlSpot(4, getRandomY()),
    ];
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  toggleHistoryMod = "Latest";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: toggleHistoryMod == "Latest"
                    ? AppColors.yellowBegaDarker
                    : Colors.grey.shade200,
              ),
              child: Text(
                'Latest',
                style: toggleHistoryMod == "Latest"
                    ? AppTextStyles.hint
                    : AppTextStyles.hintBlack,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  toggleHistoryMod = "History";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: toggleHistoryMod == "History"
                    ? AppColors.yellowBegaDarker
                    : Colors.grey.shade200,
              ),
              child: Text('History',
                  style: toggleHistoryMod == "History"
                      ? AppTextStyles.hint
                      : AppTextStyles.hintBlack),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        // LDL Cholesterol card description
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.mainBg,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        color: AppColors.yellowBega,
                      ),
                      child: SvgPicture.asset("assets/ldIcon.svg"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.title, style: AppTextStyles.title1),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                    'LDL, or low-density lipoprotein, is often referred to as the "bad" cholesterol because high levels of it can lead to a buildup of fatty deposits in your arteries...',
                    style: AppTextStyles.hintBlack),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // Borderline card with chart
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.mainBg,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                AspectRatio(
                  aspectRatio: 1.5,
                  child: ChartDot(spots: getSpots(),),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        DynamicAccordion(
          sections: sections,
        )
      ],
    );
  }
}

class HowToImproveTab extends StatefulWidget {
  late String title;

  HowToImproveTab({super.key, required this.title});

  @override
  State<HowToImproveTab> createState() => _HowToImproveTabState();
}

class _HowToImproveTabState extends State<HowToImproveTab> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.mainBg,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: AppColors.yellowBega,
                  ),
                  child: SvgPicture.asset("assets/ldIcon.svg"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.title, style: AppTextStyles.title1),
              ],
            ),
            const SizedBox(height: 10),
            Text(
                "Consider reviewing your diet and lifestyle choices, focusing on reducing saturated fats, trans fats, and cholesterol-rich foods. Incorporate more fiber-rich foods, such as fruits, vegetables, and whole grains, into your meals. Regular physical activity can also help lower LDL cholesterol levels. If you have been prescribed cholesterol-lowering medications, ensure you are taking them as directed by your doctor. If you experience chest pain, shortness of breath, or other symptoms of heart problems, please contact your doctor immediately, as high LDL cholesterol can increase your risk of heart disease. Set your LDL cholesterol test reminder in the Your Data section and track your levels over time.",
                style: AppTextStyles.hintBlackWithHeight
            ),
          ],
        ),
      ),
    );
  }
}

class InsightTab extends StatefulWidget {
  late String title;

  InsightTab({super.key, required this.title});

  @override
  State<InsightTab> createState() => _InsightTabState();
}

class _InsightTabState extends State<InsightTab> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.mainBg,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
                "Your genetic risk for elevated LDL cholesterol is average, but according to your latest blood test results, your LDL cholesterol levels are higher than optimal. Although your genetics may contribute to your cholesterol levels, your lifestyle choices, including diet, exercise, and weight management, have a more profound impact on your ability to reduce LDL cholesterol.By adopting a heart-healthy diet, increasing physical activity, and maintaining a healthy weight, you can effectively lower your LDL cholesterol, minimizing the influence of genetic factors and reducing your risk of heart disease.",
                style: AppTextStyles.hintBlackWithHeight),
          ],
        ),
      ),
    );
  }
}
