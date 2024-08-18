import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class NormalGauges extends StatelessWidget {
  late String picAddress;
  late double value;
  late Color colorGauge;
  NormalGauges({super.key, required this.picAddress, required this.colorGauge,required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
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
            padding: const EdgeInsets.all(0.0),
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
                      widget: Container(
                    child: SvgPicture.asset(
                      picAddress,
                      width: 20,
                    ),
                  ))
                ],
                axisLineStyle: const AxisLineStyle(
                  thickness: 0,
                  color: Colors.white,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    color: colorGauge,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    value: value,
                    width: 0.15,
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
