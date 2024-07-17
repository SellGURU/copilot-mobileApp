import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
          ItemCard(title: "Heart Rate",average: "84",icon: SizedBox(),status: "hi",current: "81"),

        ],)
        ),
      )
    );
  }
}


