import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LDLCholesterolChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Nov');
                    case 1:
                      return Text('Feb');
                    case 2:
                      return Text('Feb');
                    case 3:
                      return Text('Mar');
                    case 4:
                      return Text('Jun');
                    case 5:
                      return Text('Sep');
                    default:
                      return Text('');
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 160,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 159),
                FlSpot(1, 84),
                FlSpot(2, 74),
                FlSpot(3, 76),
                FlSpot(4, 92),
                FlSpot(5, 112),
              ],
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.yellow,
                  Colors.orange,
                  Colors.red,
                ],
                stops: [0.1, 0.4, 0.7, 1.0],
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.transparent,
              ),

            ),
          ],
        ),
      ),
    );
  }
}
