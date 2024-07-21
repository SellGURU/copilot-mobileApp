import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pageIndex=0;
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
            index: pageIndex,
            children: [HomeScreen(), Container(child: Text("result"),),Center(child: Text("hi"),),SettingPage()],
          ),
        ),
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            onTap: (index)=>setState(() {
              pageIndex=index;
            }),
            disableDefaultTabController: true,
            elevation: 5,
            height: (size.height*.06),
            style: TabStyle.fixed,
            backgroundColor: AppColors.mainBg,
            color: AppColors.textLite,
            activeColor: AppColors.iconPurpleDark,
            top: -35,
            curveSize: 80,
            items:[
              TabItem(
                title: "Home",
                icon: SizedBox(
                  height: (size.height),
                  // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
                  child: SvgPicture.asset("assets/homeIcon.svg",width: 5,height: 5, colorFilter: pageIndex==0?ColorFilter.mode(AppColors.purpleDark, BlendMode.srcIn):ColorFilter.mode(AppColors.textLite, BlendMode.srcIn)),
                ),
              ),
              TabItem(
                title: "Results",
                icon: SizedBox(
                  height: (size.height),
                  // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
                  child: SvgPicture.asset("assets/heartIconMenu.svg",width: 5,height: 5, colorFilter: pageIndex==1?ColorFilter.mode(AppColors.purpleDark, BlendMode.srcIn):ColorFilter.mode(AppColors.textLite, BlendMode.srcIn)),
                ),
              ),
              TabItem(
                title: "",
                icon: Container(
                  height: (size.height),
                  decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
                  child:const Icon(Icons.add,weight: 10,color: Colors.white,),
                ),
              ),
              TabItem(title: "Insight", icon: SizedBox(
                height: (size.height),
                // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
                child: SvgPicture.asset("assets/settingIcon.svg",width: 5,height: 5, colorFilter: pageIndex==3?ColorFilter.mode(AppColors.purpleDark, BlendMode.srcIn):ColorFilter.mode(AppColors.textLite, BlendMode.srcIn)),
              )),
              TabItem(title: "Setting",icon: SizedBox(
                height: (size.height),
                // decoration: BoxDecoration(color: AppColors.iconPurpleDark,borderRadius:BorderRadius.circular(99) ),
                child: SvgPicture.asset("assets/settingIcon.svg",width: 5,height: 5, colorFilter: pageIndex==4?ColorFilter.mode(AppColors.purpleDark, BlendMode.srcIn):ColorFilter.mode(AppColors.textLite, BlendMode.srcIn)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 60;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return AppTextStyles.hint;
  }
}
