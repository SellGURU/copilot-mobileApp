import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/res/colors.dart';
import 'package:test_copilet/widgets/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body: SafeArea(child:
        Column(children: [
          Text("salam amin"),
          ItemCard(title: "Heart Rate",average: "84",icon: SvgPicture.asset("assets/heart.svg",width: 40,height: 40,),status: "hi",current: "81"),

        ],)
        ),
        bottomNavigationBar: ConvexAppBar(

          style: TabStyle.fixed,
          backgroundColor: AppColors.mainBg,
          color: AppColors.textLite,
          activeColor: AppColors.greenBega,
          items: [
            TabItem(title:"Home",icon: Icons.home,),
            TabItem(title:"Results",icon: Icons.monitor_heart_sharp,),
            TabItem(title:"",icon: Container(
              width: 20,
              decoration: BoxDecoration(color: AppColors.purpleDark,borderRadius: BorderRadius.circular(20)),
              child: Icon(Icons.add,color: Colors.white,),
            )),
            TabItem(title:"Insight",icon: Icons.pages),
            TabItem(title:"Setting",icon: Icons.settings),
          ],
        ),
      )
    );
  }
}


