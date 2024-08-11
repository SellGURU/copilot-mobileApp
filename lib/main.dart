
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
import 'package:test_copilet/route/names.dart';
import 'package:test_copilet/route/routes.dart';
import 'package:test_copilet/screens/CholesterolScreen/CholesterolScreen.dart';
import 'package:test_copilet/screens/Detailed%20Plan/detailedPlan.dart';
import 'package:test_copilet/screens/home/home.dart';
import 'package:test_copilet/screens/login/login.dart';
import 'package:test_copilet/screens/CholesterolScreen/LDLChart.dart';
import 'package:test_copilet/screens/plan/planScreen.dart';
import 'package:test_copilet/screens/result/result.dart';
import 'package:test_copilet/screens/setting/settingPage.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_events.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_states.dart';
import 'package:test_copilet/utility/switchValueBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/token/clearToken.dart';
import 'package:test_copilet/utility/token/getTokenLocaly.dart';
import 'package:test_copilet/utility/token/updateToken.dart';
import 'package:test_copilet/widgets/accordion.dart';
import 'package:test_copilet/widgets/bottomNavigationBar.dart';

import 'components/text_style.dart';

void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // clearToken();
  await UpdateToken("token");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pageIndex = 0;
  bool contishen = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'copilot demo',
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenNames.root,
      routes: routes,
    );
  }
}
