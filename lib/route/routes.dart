import 'package:flutter/cupertino.dart';
import 'package:test_copilet/screens/login/login.dart';
import 'package:test_copilet/screens/mainScreen/mainScreen.dart';
import '../screens/CholesterolScreen/CholesterolScreen.dart';
import '../screens/Detailed Plan/detailedPlan.dart';
import '../screens/camera/camaraScreen.dart';
import '../screens/home/home.dart';
import 'names.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.home: (context) => const HomeScreen(),
  ScreenNames.login: (context) => const LoginPage(),
  ScreenNames.LDL: (context) => CholesterolScreen(),
  ScreenNames.detailedPlan: (context) => detailedPlan(),
  ScreenNames.cameraScreen: (context) => CameraScreen(),
};
