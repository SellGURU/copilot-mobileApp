import 'package:flutter/cupertino.dart';

import '../screens/home/home.dart';
import 'names.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.home: (context) => const HomeScreen(),
  ScreenNames.setting: (context) => const HomeScreen(),

};
