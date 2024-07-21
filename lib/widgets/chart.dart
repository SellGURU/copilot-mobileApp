import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_copilet/components/text_style.dart';
import 'package:test_copilet/components/text_style.dart';
import 'package:test_copilet/components/text_style.dart';

import '../res/colors.dart';

class Chart extends StatelessWidget {
  Chart({super.key});
  // const SettingPage({super.key});
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    switch (value.toInt()) {
      case 2:
        return Text('MAR',style: AppTextStyles.hint,);
      case 5:
        return Text('JUN',style: AppTextStyles.hint,);
      case 8:
        return Text('SEP',style: AppTextStyles.hint,);
      default:
        return SizedBox();
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    switch (value.toInt()) {
      case 1:
        return Container(width:50,child: Text('10',style: AppTextStyles.hint,));
      case 3:
        return Container(width:100,child: Text('30',style: AppTextStyles.hint,));
      case 5:
        return Container(child: Text('50',style: AppTextStyles.hint,));
      default:
        return Container();
    }
  }

  List<Color> gradientColors = [
    AppColors.brandSecondaryColor,
    AppColors.brandSecondaryColor,
  ];

  LineChartData mainData() {
    return LineChartData(
      clipData:FlClipData.none(),
      gridData: FlGridData(
        show: true,
        // drawVerticalLine: false,
        // horizontalInterval: 1,
        // verticalInterval: 1,
        // getDrawingVerticalLine: (value) {
        //   return const FlLine(
        //     color: AppColors.greenBega,
        //     strokeWidth: 1,
        //   );
        // },
      ),
      borderData:FlBorderData(
          border: Border(right: BorderSide(width: 0),left: BorderSide(width: 0),bottom: BorderSide(width: 1),)
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles:SideTitles(showTitles: false,),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta){
              return bottomTitleWidgets(value,meta);
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget:(value, meta)=> leftTitleWidgets(value,meta),
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(0.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 1,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
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
      width: 132,
      height: 60,
      child: LineChart(mainData()),
    );
  }
}
