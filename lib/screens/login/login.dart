import 'dart:async';
import 'dart:convert';

import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/screens/mainScreenV2/MainScreenV2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/text_field.dart';
import '../home/cubit/cubit.dart';
import '../login/cubit/state.dart';
import '../mainScreen/mainScreen.dart';
import '../mainScreenV2/userinfoCubit/cubit.dart';
import 'cubit/cubit.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController(); // Password controller
  final _emailController = TextEditingController(); // Email controller
  var isLoading = null;
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';
  String? _errorMessageEmail; // This will hold the error message
  String? _errorMessagePass; // This will hold the error message

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;

      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText =
            'People API gave a ${response.statusCode} response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn(context) async {
    try {
      await _googleSignIn.signIn();
      _handleAuthorizeScopes();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    setState(() {
      _isAuthorized = isAuthorized;
    });
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
  }

  // Email validation regex function
  void _validateEmail(String value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(pattern);

    setState(() {
      if (value.isEmpty) {
        _errorMessageEmail = 'Please enter an email';
      } else if (!regExp.hasMatch(value)) {
        _errorMessageEmail =
            'Account not found. Check your email again.'; // Match the error in your image
      } else {
        _errorMessageEmail = null; // Clear error if valid
      }
    });
  }

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorMessagePass = 'Please enter a password'; // If password is empty
      } else if (value.length < 6) {
        _errorMessagePass =
            'Password must be at least 6 characters long'; // Simple length check
      } else {
        _errorMessagePass = null; // Clear error if password is valid
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose(); // Dispose of password controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final GoogleSignInAccount? user = _currentUser;

    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: SafeArea(
        child: Container(
          width: size.width,
          alignment: Alignment.topCenter,
          child: Container(
            width: size.width > 420 ? 420 : size.width,
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                width: size.width > 420 ? 420 : size.width,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/Group1000004492.svg",
                          height: 350,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            left: (size.width/2)-40,
                            top: 100,
                            child: Image.asset(
                              "assets/logoIcon.png",
                              width: 70,
                              height: 70,
                            ))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                            "To continue, please enter your email and password. Your password can be found in the invitation email.",
                            style: AppTextStyles.hintBlack,
                          ),
                          const SizedBox(height: 30),
                          AppTextField(
                            lable: 'Email',
                            hint: 'Email Address',
                            controller: _emailController,
                            isPassword: false,
                          ),
                          if (_errorMessageEmail != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                _errorMessageEmail!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          const SizedBox(height: 30),
                          AppTextField(
                            lable: 'Password',
                            hint: 'Password',
                            controller: _passwordController,
                            isPassword: true, // Enable password obscuring
                          ),
                          if (_errorMessagePass != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                _errorMessagePass!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          const SizedBox(height: 30),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) async {
                              if (state is SuccessState) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    'email', _emailController.value.text);
                                prefs.setString(
                                    'password',
                                    _passwordController
                                        .value.text); // Store password
                                BlocProvider.of<ClientInformationMobileCubit>(
                                        context)
                                    .refresh();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Mainscreenv2()),
                                );
                              }
                              if (state is ErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.errorText)));
                              }
                            },
                            builder: (context, state) {
                              if (state is LoadingState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return GestureDetector(
                                onTap: () async {
                                  _validateEmail(_emailController.text);
                                  _validatePassword(
                                      _passwordController.value.text);
                                  if (_errorMessageEmail == null &&
                                      _errorMessagePass == null) {
                                    BlocProvider.of<AuthCubit>(context).logIn(
                                        _emailController.value.text,
                                        _passwordController
                                            .value.text // Pass the password
                                        );
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.purpleDark,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: size.width,
                                  child: Text(
                                    "Login",
                                    style: AppTextStyles.titleMediumWhite,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          // GestureDetector(
                          //   onTap: () => _handleSignIn(context),
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                          //     decoration: BoxDecoration(
                          //       border: Border.all(width: 2, color: AppColors.black),
                          //       color: AppColors.mainBg,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     width: size.width,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         SvgPicture.asset("assets/Google.svg"),
                          //         const SizedBox(width: 10),
                          //         Text(
                          //           "Continue with Google",
                          //           style: AppTextStyles.titleMedium,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
