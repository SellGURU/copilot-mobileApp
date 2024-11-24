import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../utility/switchValueBloc/PageIndex_Bloc.dart';
import '../../utility/switchValueBloc/PageIndex_events.dart';
import '../../utility/switchValueBloc/PageIndex_states.dart';
import '../../widgets/cardResultscreen.dart';
import '../CholesterolScreen/CholesterolScreen.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/state.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool valueSwitch = false;
  int indexItem = 0;
  String itemSelectedFiltered = "all";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<BiomarkerCubit, BiomarkerState>(
      builder: (context, state) {
        if (state is LoadingBiomarkerState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var data = state.getBiomarkerData();
        if (state is SuccessBiomarkerState) {
          return SingleChildScrollView(

            child: Container(
              margin: EdgeInsets.only(top: size.height * .02),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                          // const Icon(
                          //   Icons.notifications_none_outlined,
                          //   color: AppColors.purpleDark,
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          SvgPicture.asset(
                            "assets/notification.svg",
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ]),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                indexItem = 0;
                                itemSelectedFiltered = "blood";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: indexItem == 0
                                    ? AppColors.purpleDark
                                    : Colors.white,
                              ),
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9.0, vertical: 8),
                                child: Row(
                                  children: [
                                    // SvgPicture.asset("assets/drops.svg",
                                    //     colorFilter: ColorFilter.mode(
                                    //         indexItem == 0
                                    //             ? AppColors.mainBg
                                    //             : AppColors.textLite,
                                    //         BlendMode.srcIn)),
                                    // const SizedBox(
                                    //   width: 7,
                                    // ),
                                    Text(
                                      "Cardiovascular...",
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
                                itemSelectedFiltered = "activity";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: indexItem == 1
                                    ? AppColors.purpleDark
                                    : Colors.white,
                              ),
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9.0, vertical: 8),
                                child: Row(
                                  children: [
                                    // SvgPicture.asset("assets/weight.svg",
                                    //     colorFilter: ColorFilter.mode(
                                    //         indexItem == 1
                                    //             ? AppColors.mainBg
                                    //             : AppColors.textLite,
                                    //         BlendMode.srcIn)),
                                    // const SizedBox(
                                    //   width: 7,
                                    // ),
                                    Text(
                                      "Organ He...",
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
                                itemSelectedFiltered = "dna";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: indexItem == 2
                                    ? AppColors.purpleDark
                                    : Colors.white,
                              ),
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9.0, vertical: 8),
                                child: Row(
                                  children: [
                                    // SvgPicture.asset("assets/dna.svg",
                                    //     colorFilter: ColorFilter.mode(
                                    //         indexItem == 2
                                    //             ? AppColors.mainBg
                                    //             : AppColors.textLite,
                                    //         BlendMode.srcIn)),
                                    // const SizedBox(
                                    //   width: 7,
                                    // ),
                                    Text(
                                      "Metabolic...",
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
                                itemSelectedFiltered = "AGING";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: indexItem == 3
                                    ? AppColors.purpleDark
                                    : Colors.white,
                              ),
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9.0, vertical: 8),
                                child: Row(
                                  children: [
                                    // SvgPicture.asset("assets/monitor.svg",
                                    //     colorFilter: ColorFilter.mode(
                                    //         indexItem == 3
                                    //             ? AppColors.mainBg
                                    //             : AppColors.textLite,
                                    //         BlendMode.srcIn)),
                                    // const SizedBox(
                                    //   width: 7,
                                    // ),
                                    Text(
                                      "Immune...",
                                      style: indexItem == 3
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
                                indexItem = 4;
                                itemSelectedFiltered = "MSK";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                                color: indexItem == 4
                              ? AppColors.purpleDark
                                  : Colors.white,
                              ),
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9.0, vertical: 8),
                                child: Row(
                                  children: [
                                    // SvgPicture.asset("assets/monitor.svg",
                                    //     colorFilter: ColorFilter.mode(
                                    //         indexItem == 3
                                    //             ? AppColors.mainBg
                                    //             : AppColors.textLite,
                                    //         BlendMode.srcIn)),
                                    // const SizedBox(
                                    //   width: 7,
                                    // ),
                                    Text(
                                      "Genetic & MSK...",
                                      style: indexItem == 4
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
                            "May,12,2024",
                            style: AppTextStyles.title2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: BlocBuilder<SwitchValueGraphBloc,
                                  SwitchValueState>(
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
                          const SizedBox(width: 5,),
                          Text("Graph View",style: AppTextStyles.hintMedium,),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width,
                    height: size.height * .63,
                    child: ListView.separated(
                      itemCount: data["data"].length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index ==0){
                          return SizedBox(width: 0,);
                        }
                        if (itemSelectedFiltered ==
                                data["data"][index]["tag"] ||
                            itemSelectedFiltered == "all") {
                          return BioMarkerCard(
                            label: data["data"][index]["label"],
                            colorBadge: data["data"][index]["colorBadge"],
                          );
                        } else {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        if (itemSelectedFiltered ==
                                data["data"][index]["tag"] ||
                            itemSelectedFiltered == "all") {
                          return const SizedBox(
                            height: 20,
                          );
                        }
                        return const SizedBox(
                          height: 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text("internat Error",style: AppTextStyles.hint,),
          );
        }
      },
    );
  }
}

class BioMarkerCard extends StatelessWidget {
  String label = "";
  String unit = "";
  String colorBadge = "";
  BioMarkerCard({required this.label, required this.colorBadge});
  getColorBadge(color) {
    if (color == "red") {
      return AppColors.red;
    }
    if (color == "yellow") {
      return AppColors.yellowBegaDarker;
    }
    if (color == "green") {
      return AppColors.greenBorder;
    }
  }
  getNameBadge(color) {
    if (color == "red") {
      return "Critical";
    }
    if (color == "yellow") {
      return "Borderline";
    }
    if (color == "green") {
      return "Normal";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CholesterolScreen(
                  title: label,
                ))),
        child: Cardresultscreen(
          colorBadge: getColorBadge(colorBadge),
          badgeText: getNameBadge(colorBadge),
          title: label,
        ),
      ),
    );
  }
}
