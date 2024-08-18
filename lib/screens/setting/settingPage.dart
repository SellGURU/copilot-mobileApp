import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/token/clearToken.dart';

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
