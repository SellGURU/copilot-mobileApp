import 'package:copilet/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/text_field.dart';
import '../home/cubit/cubit.dart';
import '../login/cubit/state.dart';
import '../mainScreen/mainScreen.dart';
import 'cubit/cubit.dart';

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
  // Future<void> _handleLogin(BuildContext context) async {
  //   print("login handler");
  //   if (_userNameController.value.text.isEmpty) return;
  //   try {
  //     String token = await getTokenHttp(
  //         _userNameController.value.text, _passwordController.value.text);
  //     if (token.isNotEmpty) {
  //       await UpdateToken(token); // Assuming UpdateToken is an async function
  //       Navigator.pushNamed(context, "/HomeScreen");
  //     } else {
  //       // Handle empty token case
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Failed to retrieve token')),
  //       );
  //     }
  //   } catch (e) {
  //     // Handle errors
  //     print("error login page ${e.toString()}");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: ${e.toString()}')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding:
                EdgeInsets.only(top: size.height * .2, left: 40, right: 40),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  child: Image.asset(
                    'assets/codie.png',
                    scale: .4,
                  ),
                ),
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
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SuccessState) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Mainscreen()),
                      );
                    }
                    if (state is ErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("error in server")));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateColor.transparent),
                        onPressed: () async {
                          BlocProvider.of<AuthCubit>(context).logIn(
                              _userNameController.value.text,
                              _passwordController.value.text);
                        },
                        child: const Text("login"));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
