import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/text_style.dart';
import '../../res/colors.dart';
import '../../widgets/card.dart';
import '../../widgets/gauges.dart';
import '../../widgets/longevity.dart';
import '../../widgets/radioBtn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerSearch = TextEditingController();
    return Scaffold(
        backgroundColor: AppColors.bgScreen,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
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
                        SizedBox(
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
                        SvgPicture.asset(
                          "assets/notificationIcon.svg",
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.notifications_none_outlined,
                          color: AppColors.purpleDark,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Gauges(),
                const SizedBox(
                  height: 30,
                ),
                // AppTextField(lable: 'search', hint: 'search', controller: _controllerSearch,icon: const Icon(Icons.search),),
                const Longevity(),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: SvgPicture.asset("assets/addBio.svg"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Blood Biomarkers",
                    style: AppTextStyles.title1,
                  ),
                ),
                SizedBox(
                    height: 280,
                    child: ListView.separated(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 8, right: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return ItemCard(
                            title: "Heart Rate",
                            average: "84",
                            icon: SvgPicture.asset(
                              "assets/heart.svg",
                              colorFilter: ColorFilter.mode(
                                  Colors.blue, BlendMode.srcIn),
                              width: 40,
                              height: 40,
                            ),
                            status: "hi",
                            current: "81");
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                    )),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Check-in to track your progress",
                        style: AppTextStyles.title1,
                      ),
                      const Row()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: [
                      RadioButton(picUrl: 'assets/yoga.svg', text: 'Try a new yoga flow'),
                     const SizedBox(height: 10,),
                      RadioButton(picUrl: 'assets/pill.svg', text: 'Start taking an LAL supplement',),
                     const SizedBox(height: 10,),
                      RadioButton(picUrl: 'assets/drag.svg', text: 'Eat a probiotic food today',),
                     const SizedBox(height: 10,),
                      RadioButton(picUrl: 'assets/bump.svg', text: 'Bump up your fibre intake',),
                     const SizedBox(height: 10,),

                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
