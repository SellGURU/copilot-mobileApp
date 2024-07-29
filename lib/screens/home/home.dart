import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_copilet/widgets/Mood.dart';

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
                        SvgPicture.asset(
                          "assets/notificationIcon.svg",
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ]),
                  child: const Row(
                    children: [
                      Row(
                        children: [
                          Gauges(),
                          SizedBox(
                            width: 10,
                          ),
                          Gauges(),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: Center(child: Text("data")),
                      ),
                      Row(
                        children: [
                          Gauges(),
                          SizedBox(
                            width: 10,
                          ),
                          Gauges(),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // AppTextField(lable: 'search', hint: 'search', controller: _controllerSearch,icon: const Icon(Icons.search),),
                const Longevity(),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: SvgPicture.asset("assets/addBio.svg"),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
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
                              colorFilter: const ColorFilter.mode(
                                  Colors.blue, BlendMode.srcIn),
                              width: 40,
                              height: 40,
                            ),
                            status: "hi",
                            current: "81");
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Mood(),
                SizedBox(
                  height: 40,
                ),
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
                Container(child: TrackProgress())
              ],
            ),
          ),
        ));
  }
}
