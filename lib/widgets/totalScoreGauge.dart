import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../components/text_style.dart';

class Totalscoregauge extends StatelessWidget {
  late double value;
  late Color colorGauge;
  Totalscoregauge({super.key, required this.colorGauge, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 120,
          height: 120,
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
                          'Total Score',
                          style: AppTextStyles.hintSmale,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "$value",
                          style: AppTextStyles.title2xl,
                        ),
                      ],
                    ),
                  )
                ],
                axisLineStyle: const AxisLineStyle(
                  thickness: 0.05,
                  color: Colors.white,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    color: colorGauge,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    value: value,
                    width: 0.1,
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
