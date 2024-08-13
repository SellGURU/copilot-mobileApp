import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_copilet/route/routes.dart';

import 'package:test_copilet/screens/mainScreen/mainScreen.dart';

import 'package:test_copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';

import 'package:test_copilet/utility/switchValueBloc/PageIndex_Bloc.dart';

import 'package:test_copilet/utility/token/updateToken.dart';

import 'components/text_style.dart';

void main() async {
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
      // initialRoute: ScreenNames.root,
      routes: routes,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageIndexBloc()),
          BlocProvider(create: (_) => SwitchValueGraphBloc())
        ],
        child: const Mainscreen(),
      ),
    );
  }
}
