import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_copilet/res/colors.dart';
import 'package:test_copilet/widgets/chart.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(child: Chart(),);
  }
}
