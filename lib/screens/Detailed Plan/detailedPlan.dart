import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../widgets/accordion.dart';

class detailedPlan extends StatelessWidget {
  var sections = [
    {
      'headerText': "How this help your blood",
      'contentText': 'Content for the first section.',
    },
    {
      'headerText': "How this help your body",
      'contentText': 'Content for the second section.',
    },
    {
      'headerText': "Scientific references",
      'contentText': 'Content for the second section.',
    },
    {
      'headerText': "Tell me more",
      'contentText': 'Content for the second section.',
    },
    {
      'headerText': "Scientific references",
      'contentText': 'Content for the second section.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/gymBig.png"),
              const SizedBox(height: 16.0),
              const Text(
                'Level up your aerobic workouts',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '5 days per week, 30 minutes minimum',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Enhance the effectiveness, intensity, or overall quality of your aerobic exercise routines. Aerobic workouts, also known as cardiovascular exercises, are activities that increase your heart rate and improve the efficiency of your cardiovascular system.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 24.0),
              CheckInWidget(),
              DynamicAccordion(
                sections: sections,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(202, 202, 215, 0.3),
            // spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Check-in',
                style: AppTextStyles.title2,
              ),
              const Icon(Icons.calendar_month_sharp,
                  color: AppColors.yellowBega)
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckInDay(day: 'Su', checkedIn: true),
              CheckInDay(day: 'M', checkedIn: true),
              CheckInDay(day: 'Tu', checkedIn: true),
              CheckInDay(day: 'W', checkedIn: true),
              CheckInDay(day: 'Th', checkedIn: false),
              CheckInDay(day: 'F', checkedIn: false),
              CheckInDay(day: 'Sa', checkedIn: false),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckInDay extends StatefulWidget {
  late String day;
  late bool checkedIn;

  CheckInDay({required this.day, required this.checkedIn});

  @override
  State<CheckInDay> createState() => _CheckInDayState();
}

class _CheckInDayState extends State<CheckInDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.day,
          style: AppTextStyles.hint,
        ),
        const SizedBox(height: 8.0),
        // calender section
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: widget.checkedIn ? AppColors.greenBega : AppColors.gray,
              borderRadius: BorderRadius.circular(600)),
          child: GestureDetector(
            onTap: () => setState(() {
              widget.checkedIn = !widget.checkedIn;
            }),
            // add number
            child: Icon(
              widget.checkedIn ? Icons.check : Icons.circle_outlined,
              color: widget.checkedIn ? AppColors.mainBg : AppColors.gray,
              size: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
