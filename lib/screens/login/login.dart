import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_copilet/utility/token/updateToken.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text("login page"),
            ElevatedButton(
                onPressed: () => UpdateToken("hihihihihi"),
                child: Text("cliced"))
          ],
        ),
      ),
    );
  }
}
