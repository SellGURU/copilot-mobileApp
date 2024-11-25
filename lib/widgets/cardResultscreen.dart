import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


import '../components/text_style.dart';
import '../res/colors.dart';
import '../utility/switchValueBloc/PageIndex_Bloc.dart';
import '../utility/switchValueBloc/PageIndex_states.dart';
import 'chart.dart';

class Cardresultscreen extends StatefulWidget {
  late Color colorBadge;
  late String badgeText;
  late String title;
  Cardresultscreen(
      {super.key,
      required this.colorBadge,
      required this.badgeText,
      required this.title});

  @override
  State<Cardresultscreen> createState() => _CardresultscreenState();
}

class _CardresultscreenState extends State<Cardresultscreen> {
  double nextGaussian() {
    final random = Random();
    double u1 = random.nextDouble();
    double u2 = random.nextDouble();
    return sqrt(-2 * log(u1)) * cos(2 * pi * u2); // Box-Muller transform
  }

  double getRandomY() {
    double mean = 120; // Average heart rate (center of the range)
    double stdDev = 30; // Standard deviation for wider spread
    double randomValue = mean + stdDev * nextGaussian();
    return randomValue.clamp(60, 180); // Clamp values between 60 and 180
  }
  getSpots(){
    var spots=[
      FlSpot(1, getRandomY()),
      FlSpot(2, getRandomY()),
      FlSpot(3, getRandomY()),
      FlSpot(4, getRandomY()),
    ];
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchValueGraphBloc, SwitchValueState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          decoration: BoxDecoration(
              border:
                  Border(left: BorderSide(color: widget.colorBadge, width: 3)),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(202, 202, 215, 0.2),
                  // spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(4, 0), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyles.title1,
                      ),
                      Text(
                        widget.title,
                        style: AppTextStyles.hint,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: widget.colorBadge,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text(
                            widget.badgeText,
                            style: widget.badgeText == "Borderline"
                                ? AppTextStyles.hint
                                : AppTextStyles.hint,
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SvgPicture.asset('assets/dangerIcon.svg'),
                      //     const SizedBox(
                      //       width: 5,
                      //     ),
                      //     // Text(
                      //     //   "Need to work",
                      //     //   style: TextStyle(
                      //     //       color: widget.colorBadge,
                      //     //       fontWeight: FontWeight.w400,
                      //     //       fontSize: 12),
                      //     // )
                      //   ],
                      // )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.purpleBadgeLite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/normalheart.svg"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.badgeText,
                              style: AppTextStyles.hint,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: const BoxDecoration(
                            color: AppColors.purpleBadgeLite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                            child: Row(
                          children: [
                            SvgPicture.asset("assets/flash.svg"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Heart Health",
                              style: AppTextStyles.hint,
                            ),
                          ],
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              state.switchValue ? ChartDot(spots: getSpots(),) : const SizedBox()
            ],
          ),
        );
      },
    );
  }
}
