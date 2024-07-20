import 'dart:ffi';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/res/colors.dart';
import 'package:test_copilet/route/routes.dart';
import 'package:test_copilet/screens/home/home.dart';
import 'package:test_copilet/screens/setting/settingPage.dart';
import 'package:test_copilet/widgets/card.dart';

import 'components/text_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        title: 'copilot demo',
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: 0,
                children: [HomeScreen(), SettingPage()],
              ),
            ),
            bottomNavigationBar: StyleProvider(
              style: Style(),
              child: ConvexAppBar(
                elevation: 5,
                height: (size.height*.08),
                style: TabStyle.fixedCircle,
                backgroundColor: AppColors.mainBg,
                color: AppColors.textLite,
                activeColor: AppColors.iconPurpleDark,
                top: -30,
                curveSize: 70,
                items: const[
                  TabItem(
                    title: "Home",
                    icon: Icons.home,
                  ),
                  TabItem(
                    title: "Results",
                    icon: Icons.monitor_heart_sharp,
                  ),
                  TabItem(
                    title: "",
                    icon: Icons.add,
                  ),
                  TabItem(title: "Insight", icon: Icons.pages),
                  TabItem(title: "Setting", icon: Icons.settings),
                ],
              ),
            ),
          ),
        );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 15;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return AppTextStyles.hint;
  }
}
//IndexedStack(
//                 index: 0,
//                 children: [HomeScreen(), SettingPage()],
//               )