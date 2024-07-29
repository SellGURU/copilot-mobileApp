import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/res/colors.dart';
import 'package:test_copilet/route/routes.dart';
import 'package:test_copilet/screens/home/home.dart';
import 'package:test_copilet/screens/result/result.dart';
import 'package:test_copilet/screens/setting/settingPage.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_events.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_states.dart';
import 'package:test_copilet/utility/switchValueBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/widgets/bottomNavigationBar.dart';

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
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'copilot demo',
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageIndexBloc()),
          BlocProvider(create: (_) => SwitchValueGraphBloc())
        ],
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: BlocBuilder<PageIndexBloc, PageIndexState>(
                builder: (context, state) {
                  return IndexedStack(
                    index: state.pageIndex,
                    children: [
                      const HomeScreen(),
                      const ResultScreen(),
                      const Text("hi"),
                      const Text("plan"),
                      SettingPage()
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavigationBarCustom()),
      ),
    );
  }
}
