// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:test_copilet/components/text_style.dart';

class Gauges extends StatelessWidget {
  const Gauges({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 41,
          height: 41,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Container(
                    child: SvgPicture.asset(
                      'assets/apple.svg',
                      width: 15,
                    ),
                  ))
                ],
                endAngle: -442,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.05,
                  color: Colors.white,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    color: Colors.purple,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    value: 40,
                    width: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
              )
            ]),
          ),
        ),
        Text(
          "Photo Aging",
          style: AppTextStyles.titleSmale,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "MAE",
              style: AppTextStyles.hintSmale,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "2-5 years",
              style: AppTextStyles.titleSmale,
            )
          ],
        )
      ],
    );
  }
}
