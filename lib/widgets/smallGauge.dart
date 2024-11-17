import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../components/text_style.dart';
import '../res/colors.dart';

class SmallGauge extends StatelessWidget {
  late double value;
  late Color colorGauge;
  SmallGauge({super.key, required this.colorGauge, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: AppColors.purpleLite,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(.1),
              //     spreadRadius: 5,
              //     blurRadius: 5,
              //     offset: const Offset(0, 1), // changes position of shadow
              //   ),
              // ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: -90,
                endAngle: -90,
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    horizontalAlignment: GaugeAlignment.center,
                    verticalAlignment: GaugeAlignment.center,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$value%",
                          style: AppTextStyles.titleSmaleBold,
                        ),
                      ],
                    ),
                  )
                ],
                axisLineStyle:  const AxisLineStyle(
                  thickness: 0.14,
                  color:AppColors.mainBg,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    color: colorGauge,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    value: value,
                    width: 0.14,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }
}
