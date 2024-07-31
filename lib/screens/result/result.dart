// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_copilet/components/text_style.dart';

import '../../res/colors.dart';
import '../../utility/switchValueBloc/PageIndex_Bloc.dart';
import '../../utility/switchValueBloc/PageIndex_events.dart';
import '../../utility/switchValueBloc/PageIndex_states.dart';
import '../../widgets/cardResultscreen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool valueSwitch = false;
  int indexItem = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Results",
                style: AppTextStyles.title1,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.purpleDark,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    "assets/notificationIcon.svg",
                    width: 25,
                    height: 25,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 0 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/drops.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 0
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Blood",
                            style: indexItem == 0
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 1 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/weight.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 1
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Activity",
                            style: indexItem == 1
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 2 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/dna.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 2
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "DNA",
                            style: indexItem == 2
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexItem = 3;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color:
                          indexItem == 3 ? AppColors.purpleDark : Colors.white,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/monitor.svg",
                              colorFilter: ColorFilter.mode(
                                  indexItem == 3
                                      ? AppColors.mainBg
                                      : AppColors.textLite,
                                  BlendMode.srcIn)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "AGING",
                            style: indexItem == 3
                                ? AppTextStyles.hintWhite
                                : AppTextStyles.hint,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Last Update:",
                    style: AppTextStyles.hint,
                  ),
                  Text(
                    "May 12 , 2024",
                    style: AppTextStyles.title2,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                width: 50,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: BlocBuilder<SwitchValueGraphBloc, SwitchValueState>(
                    builder: (context, state) {
                      return CupertinoSwitch(
                        autofocus: false,
                        activeColor: AppColors.iconPurpleDark,
                        value: state.switchValue,
                        onChanged: (value) {
                          print(state.switchValue);
                          BlocProvider.of<SwitchValueGraphBloc>(context)
                              .add(UpdateSwitchValueGraph(value));
                          // valueSwitch = value;
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Cardresultscreen(),
        ],
      ),
    );
  }
}
