import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/text_style.dart';
import 'chart.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String status;
  final String average;
  final String current;
  final Widget icon;

  ItemCard(
      {super.key,
      required this.title,
      required this.average,
      required this.current,
      required this.icon,
      required this.status});

  @override
  Widget build(BuildContext context) {
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
          borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                  child: icon,
                ),
                Text(
                  title,
                  style: AppTextStyles.title1,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
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
                          average,
                          style: AppTextStyles.title1,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "bpm",
                          style: AppTextStyles.hint,
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Avg",
                      style: AppTextStyles.hint,
                    ),
                    Row(
                      children: [
                        Text(
                          average,
                          style: AppTextStyles.title1,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "bpm",
                          style: AppTextStyles.hint,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ChartDot(),
            // Row(
            //   children:[
            //     LineChart(mainData())
            //   ]
            // )
          ],
        ),
      ),
    );
  }
}
