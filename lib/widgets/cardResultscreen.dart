import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_copilet/components/text_style.dart';
import 'package:test_copilet/res/colors.dart';
import 'package:test_copilet/widgets/chart.dart';

import '../utility/switchValueBloc/PageIndex_Bloc.dart';
import '../utility/switchValueBloc/PageIndex_states.dart';

class Cardresultscreen extends StatefulWidget {
  const Cardresultscreen({super.key});

  @override
  State<Cardresultscreen> createState() => _CardresultscreenState();
}

class _CardresultscreenState extends State<Cardresultscreen> {
  String title = "LDL Cholesterol";
  String badgeText = "Borderline";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchValueGraphBloc, SwitchValueState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          decoration: BoxDecoration(
              border: Border(
                  left:
                      BorderSide(color: AppColors.yellowBegaDarker, width: 3)),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(3, 1), // changes position of shadow
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
                        title,
                        style: AppTextStyles.title1,
                      ),
                      Text(
                        title,
                        style: AppTextStyles.hint,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.yellowBegaDarker,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text(
                            badgeText,
                            style: AppTextStyles.hint,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/dangerIcon.svg'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Need to work",
                            style: TextStyle(
                                color: AppColors.yellowBegaDarker,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
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
                              badgeText,
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
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              state.switchValue ? Chart():const SizedBox()
            ],
          ),
        );
      },
    );
  }
}
