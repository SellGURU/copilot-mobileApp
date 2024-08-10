import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/gymBig.png"),
            SizedBox(height: 16.0),
            Text(
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
          ],
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
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check-in',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
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

class CheckInDay extends StatelessWidget {
  final String day;
  final bool checkedIn;

  CheckInDay({required this.day, required this.checkedIn});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: checkedIn ? Colors.green : Colors.grey,
          ),
        ),
        SizedBox(height: 8.0),
        Icon(
          checkedIn ? Icons.check_circle : Icons.circle_outlined,
          color: checkedIn ? Colors.green : Colors.grey,
          size: 32.0,
        ),
      ],
    );
  }
}
