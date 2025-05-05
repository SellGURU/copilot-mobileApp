import 'package:copilet/res/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class ChartDot extends StatelessWidget {
  var spots;
  var labels;
  ChartDot({super.key,required this.spots, required this.labels});



  // Month labels for the X-axis
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return Text(
      labels[value.toInt()],
      style: TextStyle(fontSize: 6, color: Colors.grey),
    );
  }

  // No left titles (Y-axis values hidden for a cleaner UI)
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return const SizedBox(width: 0, height: 0);
  }

  // Define gradient colors for the chart
  List<Color> gradientColors = [
    AppColors.greenBega,
    AppColors.greenBega,
  ];

  // Calculate min and max Y values from spots
  double getMinY() {
    if (spots.isEmpty) return 0;
    return spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b) - 3;
  }

  double getMaxY() {
    if (spots.isEmpty) return 100;
    return spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
  }

  // Line chart data configuration
  LineChartData mainData() {
    double minY = getMinY();
    double maxY = getMaxY();
    // Add some padding to the min and max values
    double padding = (maxY - minY) * 0.1;
    minY = (minY - padding).clamp(0, double.infinity);
    maxY = maxY + padding;

    return LineChartData( 
      gridData: const FlGridData(
        show: false,
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      minY: minY,
      maxY: maxY,
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
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
          spots: spots,
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
              strokeColor: AppColors.greenBega,
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


