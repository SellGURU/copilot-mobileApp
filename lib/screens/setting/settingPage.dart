import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_copilet/utility/token/clearToken.dart';
import 'package:test_copilet/utility/token/getTokenHttp.dart';
import 'package:test_copilet/widgets/chart.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
      onPressed: () {
        clearToken();
        // getTokenHttp("amin75t", "1");
        Navigator.pushNamed(context, "/login");
      },
      child: const Text("delete token"),
    ));
  }
}
