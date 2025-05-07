/// This file defines the CholesterolScreen widget, which provides a screen with multiple tabs
/// to display information about cholesterol, including results, ways to improve cholesterol levels, and insights.

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

/// CholesterolScreen displays information related to cholesterol levels. It has three tabs:
/// "Result", "How to improve", and "Insight".
/// The screen also includes visual charts and accordion sections with detailed content.

class CholesterolScreen extends StatefulWidget {
  final String title;
  Object data;

  CholesterolScreen({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  State<CholesterolScreen> createState() => _CholesterolScreenState();
}

class _CholesterolScreenState extends State<CholesterolScreen> {
  var indexItem = 0;  // Tracks the active tab (0 - Result, 1 - How to improve, 2 - Insight)

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgScreen,
        actions: [
          Text("", style: AppTextStyles.title1),
          SizedBox(width: size.width * .40),
          Row(
            children: [
              SvgPicture.asset("assets/notificationIcon.svg", width: 25, height: 25),
              const SizedBox(width: 5),
              const Icon(Icons.notifications_none_outlined, color: AppColors.purpleDark),
              const SizedBox(width: 15),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header tabs with navigation between "Result", "How to improve", and "Insight"
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            indexItem = 0;
                          });
                        },
                        child: _buildTabButton("Result", "assets/drops.svg", indexItem == 0),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            indexItem = 1;
                          });
                        },
                        child: _buildTabButton("How to improve", "assets/message-question.svg", indexItem == 1),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            indexItem = 2;
                          });
                        },
                        child: _buildTabButton("Insight", "assets/lamp-on.svg", indexItem == 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // IndexedStack to switch between the tabs
                IndexedStack(
                  index: indexItem,
                  children: [
                    ResultMainTab(title: widget.title, data: widget.data),
                    HowToImproveTab(title: widget.title, data: widget.data),
                    InsightTab(title: widget.title, data: widget.data),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build tab buttons with appropriate styling
  Widget _buildTabButton(String label, String icon, bool isActive) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: isActive ? AppColors.purpleDark : Colors.white,
      ),
      height: 50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: 8),
        child: Row(
          children: [
            SvgPicture.asset(icon, colorFilter: ColorFilter.mode(isActive ? AppColors.mainBg : AppColors.textLite, BlendMode.srcIn)),
            const SizedBox(width: 7),
            Text(label, style: isActive ? AppTextStyles.hintWhite : AppTextStyles.hint),
          ],
        ),
      ),
    );
  }
}

/// ResultMainTab displays detailed information about cholesterol results with options for toggling
/// between the "Latest" and "History" modes. It includes charts and accordion-style sections.

class ResultMainTab extends StatefulWidget {
  final String title;
  final Object data;

  ResultMainTab({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  State<ResultMainTab> createState() => _ResultMainTabState();
}

class _ResultMainTabState extends State<ResultMainTab> {
  var toggleHistoryMod = "History";
  late final List<Map<String, String>> sections;

  @override
  void initState() {
    super.initState();
    sections = [
      {'headerText': 'What ${widget.title} means for your health?', 'contentText': (widget.data as Map<String, dynamic>)['what_it_means']},
      {'headerText': 'What your body says', 'contentText': (widget.data as Map<String, dynamic>)['what_body_says']},
    ];
  }

  double nextGaussian() {
    final random = Random();
    double u1 = random.nextDouble();
    double u2 = random.nextDouble();
    return sqrt(-2 * log(u1)) * cos(2 * pi * u2);  // Box-Muller transform
  }

  double getRandomY() {
    double mean = 120;
    double stdDev = 30;
    double randomValue = mean + stdDev * nextGaussian();
    return randomValue.clamp(60, 180);
  }

  getSpots(){
    var data = widget.data as Map<String, dynamic>;   
    var values = data['values'] as List<dynamic>? ?? [];
    var spots = values.asMap().entries.map((entry) => 
      FlSpot(entry.key.toDouble(), double.tryParse(entry.value.toString()) ?? 0)
    ).toList();
    return spots;
  }

  getLabels() {
    var labels = ['2024-01-01', '2024-01-02', '2024-01-03', '2024-01-04'];
    return labels;
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
                backgroundColor: toggleHistoryMod == "Latest" ? AppColors.yellowBegaDarker : Colors.grey.shade200,
              ),
              child: Text('Latest', style: toggleHistoryMod == "Latest" ? AppTextStyles.hint : AppTextStyles.hintBlack),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  toggleHistoryMod = "History";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: toggleHistoryMod == "History" ? AppColors.yellowBegaDarker : Colors.grey.shade200,
              ),
              child: Text('History', style: toggleHistoryMod == "History" ? AppTextStyles.hint : AppTextStyles.hintBlack),
            ),
          ],
        ),
        const SizedBox(height: 15),
        // LDL Cholesterol card description
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    const SizedBox(width: 10),
                    Text(widget.title, style: AppTextStyles.title1),
                  ],
                ),
                const SizedBox(height: 10),
                Text((widget.data as Map<String, dynamic>)['more_info'],
                    style: AppTextStyles.hintBlack),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Chart card for LDL Cholesterol visualization
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColors.mainBg,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                AspectRatio(aspectRatio: 1.5, child: ChartDot(spots: getSpots(), labels: getLabels())),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Accordion section
        DynamicAccordion(sections: sections),
      ],
    );
  }
}

/// HowToImproveTab displays information and tips on how to improve cholesterol levels through diet and lifestyle changes.

class HowToImproveTab extends StatefulWidget {
  final String title;
  final Object data;

  HowToImproveTab({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  State<HowToImproveTab> createState() => _HowToImproveTabState();
}

class _HowToImproveTabState extends State<HowToImproveTab> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                const SizedBox(width: 10),
                Text("How to Improve", style: AppTextStyles.title1),
              ],
            ),
            const SizedBox(height: 10),
            Text((widget.data as Map<String, dynamic>)['how_to_improve'],
                style: AppTextStyles.hintBlack),
            const SizedBox(height: 10),
            // Add your content on lifestyle improvements here
          ],
        ),
      ),
    );
  }
}

/// InsightTab provides insights and tips based on cholesterol levels, such as further steps and assessments.

class InsightTab extends StatefulWidget {
  final String title;
  final Object data;

  InsightTab({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  State<InsightTab> createState() => _InsightTabState();
}

class _InsightTabState extends State<InsightTab> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                const SizedBox(width: 10),
                Text("Insights", style: AppTextStyles.title1),
              ],
            ),
            const SizedBox(height: 10),
            Text((widget.data as Map<String, dynamic>)['insight'],
                style: AppTextStyles.hintBlack),
          ],
        ),
      ),
    );
  }
}
