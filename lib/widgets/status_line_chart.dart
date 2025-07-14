import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:copilet/models/chartStatus.dart';
import 'package:copilet/models/status_background_painter.dart';
// widgets/status_line_chart.dart

class StatusLineChart extends StatelessWidget {
  final List<FlSpot> spots;
  final List<Color> gradientColors;
  final List<ChartStatus> statusList;

  const StatusLineChart({
    super.key,
    required this.spots,
    required this.gradientColors,
    required this.statusList,
  });

  double getMinY() => spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
  double getMaxY() => spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);

  @override
  Widget build(BuildContext context) {
    final double minY = (getMinY() - (getMaxY() - getMinY()) * 0.1).clamp(0, double.infinity);
    final double maxY = getMaxY() + (getMaxY() - getMinY()) * 0.1;

    // padding‌هایی که FlTitlesData استفاده می‌کنه
    const leftPad = 0.0;
    const bottomPad = 80.0;
    const topPad = 100.0;
    const rightPad = 0.0;

    return AspectRatio(
      aspectRatio: 1.7,
      child: Stack(
        children: [
          // پس‌زمینه وضعیت‌ها
          Positioned.fill(
            child: CustomPaint(
              painter: StatusBackgroundPainter(
                statusList: statusList,
                minY: minY,
                maxY: maxY,
                leftPadding: leftPad,
                bottomPadding: bottomPad,
                topPadding: topPad,
                rightPadding: rightPad,
              ),
            ),
          ),
          // نمودار خطی
          LineChart(
            LineChartData(
              minY: minY,
              maxY: maxY,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                  left: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: leftPad,
                    getTitlesWidget: (value, meta) => Text(value.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 10)),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: bottomPad,
                    getTitlesWidget: (value, meta) => Text(value.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 10)),
                  ),
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
                  gradient: LinearGradient(colors: gradientColors),
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                      radius: 3,
                      color: Colors.white,
                      strokeWidth: 2,
                      strokeColor: Colors.green,
                    ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: gradientColors.map((c) => c.withOpacity(0.2)).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
