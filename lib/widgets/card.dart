import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/text_style.dart';
import 'chart.dart';

class ItemCard extends StatefulWidget {
  final String title;
  final String status;
  final String average;
  final String current;
  String scale;
  final Widget icon;

  ItemCard({
    super.key,
    required this.scale,
    required this.title,
    required this.average,
    required this.current,
    required this.icon,
    required this.status,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late List<FlSpot> spots; // State variable for spots

  @override
  void initState() {
    super.initState();
    spots = getSpots(); // Generate spots once during initialization
  }

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

  List<FlSpot> getSpots() {
    return [
      FlSpot(1, getRandomY()),
      FlSpot(2, getRandomY()),
      FlSpot(3, getRandomY()),
      FlSpot(4, getRandomY()),
    ];
  }

  double calculateAverageY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0; // Handle empty spots list
    double total = spots.fold(0, (sum, spot) => sum + spot.y);
    return total / spots.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageY = calculateAverageY(spots); // Calculate average once

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: 200,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: widget.icon,
                ),
                Text(
                  widget.title,
                  style: AppTextStyles.title1,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Avg",
                      style: AppTextStyles.hint,
                    ),
                    Row(
                      children: [
                        Text(
                          "${averageY.round()}", // Display average Y
                          style: AppTextStyles.title1,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.scale,
                          style: AppTextStyles.hint,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Current",
                      style: AppTextStyles.hint,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.current, // Display current value
                          style: AppTextStyles.title1,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.scale,
                          style: AppTextStyles.hint,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            ChartDot(spots: spots), // Pass the same spots to ChartDot
          ],
        ),
      ),
    );
  }
}
