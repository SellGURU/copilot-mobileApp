import 'package:flutter/cupertino.dart';

import '../screens/CholesterolScreen/CholesterolScreen.dart';
import '../screens/Detailed Plan/detailedPlan.dart';
import '../screens/camera/camaraScreen.dart';
import '../screens/home/home.dart';
import '../screens/login/login.dart';
import 'names.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.home: (context) => const Overview(),
  ScreenNames.login: (context) => const LoginPage(),
  ScreenNames.LDL: (context) => CholesterolScreen(title: '',),
  ScreenNames.detailedPlan: (context) => detailedPlan(),
  ScreenNames.cameraScreen: (context) => CameraScreen(),
};
