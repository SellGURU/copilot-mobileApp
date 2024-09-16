import 'package:copilet/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentIndicator extends StatefulWidget {
  const PercentIndicator({super.key});

  @override
  State<PercentIndicator> createState() => _PercentIndicatorState();
}

class _PercentIndicatorState extends State<PercentIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearPercentIndicator(
      backgroundColor: AppColors.textLite,
        lineHeight: 14.0,
        percent: 0.5,
      ),
    );
  }
}
