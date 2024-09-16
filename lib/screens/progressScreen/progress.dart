import 'package:copilet/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/text_style.dart';
import '../../widgets/PercentIndicator.dart';
import '../../widgets/normal-Gauges.dart';
import '../../widgets/smallGauge.dart';
import '../../widgets/totalScoreGauge.dart';

class ProgressScreen extends StatefulWidget {
  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Progress",
                        style: AppTextStyles.title1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
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
              // Progress Bar Plan Section

              PlanProgressSection(),
              SizedBox(height: 16),
              // Daily Goals Section
              GoalCompletionSection(),
              SizedBox(height: 16),
              // Challenges Section
              ChallengesSection(),
              SizedBox(height: 16),
              // Tasks Section
              Text("Tasks" ,style: AppTextStyles.title2,),
              const SizedBox(height: 10,),

              WaterTaskWidget(),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              WaterTaskWidget(),
              const SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}

// Plan Progress Section
class PlanProgressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: AppColors.mainBg,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // rgba(201, 235, 237, 1)
              color: AppColors.mainShadow.withOpacity(.25),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(4, 0), // changes position of shadow
            ),
          ]),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Your Weekly Progress',
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          // ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BarChartWidget(
                  day: 'Sun',
                  mainPlan: 0.8,
                  color: AppColors.greenLite,
                  alternativePlan: 0.4),
              BarChartWidget(
                  day: 'Mon',
                  mainPlan: 0.7,
                  color: AppColors.greenLite,
                  alternativePlan: 0.3),
              BarChartWidget(
                  day: 'Tue',
                  mainPlan: 0.9,
                  color: AppColors.greenLite,
                  alternativePlan: 0.5),
              BarChartWidget(
                  day: 'Wed',
                  mainPlan: 0.7,
                  color: AppColors.greenLite,
                  alternativePlan: 0.2),
              BarChartWidget(
                  day: 'Thu',
                  mainPlan: 0.9,
                  color: AppColors.greenLite,
                  alternativePlan: 0.6),
              BarChartWidget(
                  day: 'Fri',
                  mainPlan: 0.5,
                  color: AppColors.greenLite,
                  alternativePlan: 0.1),
              BarChartWidget(
                  day: 'Sat',
                  mainPlan: 0.6,
                  color: AppColors.greenLite,
                  alternativePlan: 0.7),
            ],
          ),
        ],
      ),
    );
  }
}

// Bar Chart Widget for weekly progress
class BarChartWidget extends StatelessWidget {
  final String day;
  final double mainPlan;
  final double alternativePlan;
  final Color color;

  const BarChartWidget(
      {required this.day,
      required this.mainPlan,
      required this.alternativePlan,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 80,
              width: 16,
              decoration: BoxDecoration(
                color: AppColors.bgChartProgress,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 80 * alternativePlan,
                width: 16,
                decoration: BoxDecoration(
                  color: this.color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(day, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Daily Goal Completion Section
class GoalCompletionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.purpleLite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
              child: SmallGauge(
            colorGauge: AppColors.pinkBorder,
            value: 25,
          )),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Your daily goals almost done!',
                      style: AppTextStyles.titleMedium),
                  Icon(Icons.local_fire_department, color: Colors.orange),
                ],
              ),
              SizedBox(height: 8),
              Text('1 of 4 completed', style: AppTextStyles.hint),
            ],
          ),
        ],
      ),
    );
  }
}

// Challenges Section
class ChallengesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Challenges",
          style: AppTextStyles.title2,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  // rgba(201, 235, 237, 1)
                  color: AppColors.mainShadow.withOpacity(.25),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(4, 0), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.blue.withOpacity(.5)),
                      SizedBox(width: 8),
                      Text('Best Runners!', style: AppTextStyles.hintMedium),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('5 days 13 hours left', style: AppTextStyles.hint),
                    Text("2 friends joined", style: AppTextStyles.hint)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                value: 500 / 2000,
                backgroundColor: AppColors.gray,
                color: AppColors.yellowLite,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Tasks Section
class TasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Drink the water', style: TextStyle(fontSize: 16)),
              IconButton(
                icon: Icon(Icons.swap_horiz),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: 500 / 2000,
            backgroundColor: Colors.grey[300],
            color: Colors.green,
          ),
          SizedBox(height: 8),
          Text('500/2000 ML'),
        ],
      ),
    );
  }
}
class WaterTaskWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainShadow.withOpacity(.25),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(4, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Circular Progress and Water Icon
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      value: 0.3, // Progress based on 500/2000 ML
                      backgroundColor: Colors.blue[100],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const Icon(
                      Icons.water_drop,
                      color: Colors.blue,
                      size: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              // Task Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drink the water',
                    style: AppTextStyles.hintMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '500/2000 ML',
                    style: AppTextStyles.hint,
                  ),
                ],
              ),
            ],
          ),
          // Swap and Add (+) Buttons
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    // isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SwapBottomSheet();
                    },
                  );
                },
                child: Column(
                  children: [
                    SvgPicture.asset("assets/repeat-circle.svg"),
                    Text(
                      'Swap',
                      style: AppTextStyles.hint,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                "assets/AddButton.svg",
                width: 35,
                height: 35,
              )
            ],
          ),
        ],
      ),
    );
  }
}


// Swap Bottom Sheet Content
class SwapBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
    
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 50,),
              Text(
                  'Swap for Water',
                  style: AppTextStyles.titleBig),
              IconButton(
                icon: Icon(Icons.close,color: AppColors.purpleDark,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          // Search bar
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search to swap...',
              border: InputBorder.none
            ),
          ),
          SizedBox(height: 90),
          // Placeholder for items to swap
        ],
      ),
    );
  }
}