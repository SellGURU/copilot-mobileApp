import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_copilet/components/text_style.dart';

import '../res/colors.dart';
import 'dart:math';

class ChartDot extends StatelessWidget {
  ChartDot({super.key});
  double getRandomX() => Random().nextDouble() * 5;
  double getRandomY() => Random().nextDouble() * 160 + 50;
  // const SettingPage({super.key});
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    switch (value.toInt()) {
      case 1:
        return Text(
          'MAR',
          style: AppTextStyles.hintVerySmale,
        );
      case 2:
        return Text(
          'MAR',
          style: AppTextStyles.hintVerySmale,
        );
      case 3:
        return Text(
          'SEP',
          style: AppTextStyles.hintVerySmale,
        );
      case 4:
        return Text(
          'JUN',
          style: AppTextStyles.hintVerySmale,
        );
      case 5:
        return Text(
          'JUN',
          style: AppTextStyles.hintVerySmale,
        );
      default:
        return Text(
          "",
          style: AppTextStyles.hintVerySmale,
        );
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    // value.toInt()
    // Container(
    //     width: 100,
    //     child: Text(
    //       '30',
    //       style: AppTextStyles.hintVerySmale,
    //     ));
    if (value.toInt() == 40 || value.toInt() == 160) {
      return Container(
          width: 100,
          child: Text(
            "${value.toInt()}",
            style: AppTextStyles.hintVerySmale,
          ));
    }
    print(meta.axisPosition);
    // if(meta.axisPosition.isFinite)
    return SizedBox();
  }

  List<Color> gradientColors = [
    AppColors.brandSecondaryColor,
    AppColors.brandSecondaryColor,
  ];

  LineChartData mainData() {
    return LineChartData(
      clipData: const FlClipData.none(),
      gridData: const FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 4,
        // verticalInterval: 1,
        // getDrawingVerticalLine: (value) {
        //   return const FlLine(
        //     color: AppColors.greenBega,
        //     strokeWidth: 1,
        //   );
        // },
      ),
      borderData: FlBorderData(
          border: const Border(
        // right: BorderSide(width: 0, color: Colors.transparent),
        // left: BorderSide(
        //   width: 0,
        //   color: Colors.red,
        //   style: BorderStyle.solid,
        // ),
        bottom: BorderSide(width: 1),
      )),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return bottomTitleWidgets(value, meta);
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta),
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 0),
            FlSpot(1, 70),
            FlSpot(2, getRandomY()),
            FlSpot(3, getRandomY()),
            FlSpot(4, getRandomY()),
            FlSpot(5, getRandomY()),

          ],
          isCurved: true,
          shadow: BoxShadow(
            color: Colors.purple.withOpacity(.5),
            spreadRadius: 20,
            blurRadius: 20,
            offset: const Offset(0, 3), // changes position of shadow
          ),
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
                FlDotCirclePainter(
                    radius: 1,
                    color: Colors.white,
                    strokeWidth: 3,
                    strokeColor: AppColors.brandSecondaryColor),
            checkToShowDot: (spot, barData) {
              return true;
            },
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // decoration: BoxDecoration(border: Border.all(width: 2)),
      child: LineChart(mainData()),
    );
  }
}
