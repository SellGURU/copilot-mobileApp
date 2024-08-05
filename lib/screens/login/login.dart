import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_copilet/utility/token/getTokenHttp.dart';
import 'package:test_copilet/utility/token/updateToken.dart';

import '../../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  var isLoading = null;

  // TODO: need validation form
  Future<void> _handleLogin(BuildContext context) async {
    try {
      String token = await getTokenHttp(
          _userNameController.value.text, _passwordController.value.text);
      if (token.isNotEmpty) {
        await UpdateToken(token); // Assuming UpdateToken is an async function
        Navigator.pushNamed(context, "/HomeScreen");
      } else {
        // Handle empty token case
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to retrieve token')),
        );
      }
    } catch (e) {
      // Handle errors
      print("error login page ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return new Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: EdgeInsets.symmetric(horizontal: 40),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextField(
                  lable: 'username',
                  hint: 'username',
                  controller: _userNameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextField(
                  lable: 'pass',
                  hint: 'password',
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _handleLogin(context);
                    },
                    child: const Text("login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
