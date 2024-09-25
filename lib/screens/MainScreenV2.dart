import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../components/text_style.dart';
import '../res/colors.dart';
import '../utility/changeScreanBloc/PageIndex_Bloc.dart';
import '../utility/changeScreanBloc/PageIndex_states.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Mainscreenv2 extends StatefulWidget {
  const Mainscreenv2({super.key});

  @override
  State<Mainscreenv2> createState() => _Mainscreenv2State();
}

class _Mainscreenv2State extends State<Mainscreenv2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgScreen,
        body: SafeArea(
          child: BlocBuilder<PageIndexBloc, PageIndexState>(
            builder: (context, state) {
              // setState(() {
              //   pageIndex = state.pageIndex;
              // });
              return const IndexedStack(
                index: 0,
                children: [
                  Overview2(),
                ],
              );
            },
          ),
        ));
  }
}
class Overview2 extends StatelessWidget {
  const Overview2({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerSearch = TextEditingController();
    return Scaffold(
        backgroundColor: AppColors.bgScreen,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/avatar.svg",
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Good morning",
                              style: AppTextStyles.hint,
                            ),
                            Text(
                              "Alexander",
                              style: AppTextStyles.title1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/document-download.svg",
                              width: 16,
                              height: 16,
                              colorFilter: const ColorFilter.mode(
                                AppColors.purpleLite,                 // The color you want to apply
                                BlendMode.srcIn,            // Blend mode to apply the color
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Text("Weekly Report",style: AppTextStyles.hintLitePurple,),

                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/document-download.svg",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 5,),
                            Text("Report",style: AppTextStyles.hintPurple,),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Longevity2(),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: SvgPicture.asset("assets/Group20.svg"),
                ),
              ],
            ),
          ),
        ));
  }
}
class Longevity2 extends StatefulWidget {
  const Longevity2({super.key});

  @override
  State<Longevity2> createState() => _Longevity2State();
}

class _Longevity2State extends State<Longevity2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Container(alignment: Alignment.centerLeft,child: Text("Longevity2 Theme",style: AppTextStyles.title1,)),
        SizedBox(height: 10,),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(3, 0), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/human-body-silhouette-with-focus-on-respiratory-system-svgrepo-com 1.svg",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 5,),
                        Center(
                            child: Text(
                              "Physiological",
                              style: AppTextStyles.title2,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Health Score: ",
                          style: AppTextStyles.hint,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Color.fromRGBO(6, 199, 141, .4),borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Text("${"90"}/100",style: AppTextStyles.gradeGreen,),
                          ),
                        ),
                        SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textLite,)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/activityIcon.svg",
                          width: 30,
                          height: 30,
                          colorFilter: const ColorFilter.mode(
                            AppColors.purpleDark,                 // The color you want to apply
                            BlendMode.srcIn,            // Blend mode to apply the color
                          ),
                        ),
                        SizedBox(width: 5,),
                        Center(
                            child: Text(
                              "Activity",
                              style: AppTextStyles.title2,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Health Score: ",
                          style: AppTextStyles.hint,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Color.fromRGBO(6, 199, 141, .4),borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Text("${"89"}/100",style: AppTextStyles.gradeGreen,),
                          ),
                        ),
                        SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textLite,)
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/mid.svg",
                          width: 30,
                          height: 30,
                          colorFilter: const ColorFilter.mode(
                            AppColors.purpleDark,                 // The color you want to apply
                            BlendMode.srcIn,            // Blend mode to apply the color
                          ),
                        ),
                        SizedBox(width: 5,),
                        Center(
                            child: Text(
                              "Mind",
                              style: AppTextStyles.title2,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Health Score: ",
                          style: AppTextStyles.hintSmale,
                        ),
                        Container(
                          decoration: BoxDecoration(color: AppColors.yellowBega.withOpacity(.2),borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 5,left: 12,right: 12),
                            child: Text("${"56"}/100",style: AppTextStyles.gradeYellow,),
                          ),
                        ),
                        SizedBox(width: 5,),
                        const Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textLite,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
