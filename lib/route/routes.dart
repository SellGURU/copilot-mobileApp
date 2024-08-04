import 'package:flutter/cupertino.dart';
import 'package:test_copilet/screens/login/login.dart';

import '../screens/home/home.dart';
import 'names.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.home: (context) => const HomeScreen(),
  ScreenNames.login: (context) => const LoginPage(),

};
