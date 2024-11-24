import 'package:copilet/res/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class ChartDot extends StatelessWidget {
  ChartDot({super.key});

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


  // Month labels for the X-axis
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    switch (value.toInt()) {
      case 1:
        return const Text(
          'May',
          style: TextStyle(fontSize: 6, color: Colors.grey),
        );
      case 2:
        return const Text(
          'June',
          style: TextStyle(fontSize: 6, color: Colors.grey),
        );
      case 3:
        return const Text(
          'July',
          style: TextStyle(fontSize: 6, color: Colors.grey),
        );
      case 4:
        return const Text(
          'August',
          style: TextStyle(fontSize: 6, color: Colors.grey),
        );
      default:
        return const Text(
          '',
          style: TextStyle(fontSize: 6, color: Colors.grey),
        );
    }
  }

  // No left titles (Y-axis values hidden for a cleaner UI)
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return const SizedBox(width: 0, height: 0);
  }

  // Define gradient colors for the chart
  List<Color> gradientColors = [
    AppColors.brandSecondaryColor,
    AppColors.brandSecondaryColor,
  ];

  // Line chart data configuration
  LineChartData mainData() {
    return LineChartData(
      maxY: 180,
      minY: 40,
      gridData: const FlGridData(
        show: false,
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta),
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      lineBarsData: [
        LineChartBarData(

          spots: [
            FlSpot(1, getRandomY()),
            FlSpot(2, getRandomY()),
            FlSpot(3, getRandomY()),
            FlSpot(4, getRandomY()),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 3,
              color: Colors.white,
              strokeWidth: 2,
              strokeColor: AppColors.purpleDark,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.2)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Chart height
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LineChart(mainData()),
    );
  }
}


