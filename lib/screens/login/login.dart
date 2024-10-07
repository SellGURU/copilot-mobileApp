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

  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  var isLoading = null;
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
// #enddocregion CanAccessScopes

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    _googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
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
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
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
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Mainscreen()),
      // );
      print(error);
    }
  }

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    // #enddocregion RequestScopes
    setState(() {
      _isAuthorized = isAuthorized;
    });
    // #docregion RequestScopes
    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => Mainscreenv2()),
    // );
    // #enddocregion RequestScopes
  }

  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage; // This will hold the error message

  // Email validation regex function
  void _validateEmail(String value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(pattern);

    setState(() {
      if (value.isEmpty) {
        _errorMessage = 'Please enter an email';
      } else if (!regExp.hasMatch(value)) {
        _errorMessage =
            'Account not found. Check your email again.'; // Match the error in your image
      } else {
        _errorMessage = null; // Clear error if valid
      }
    });
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
          alignment: Alignment.center,
          child: Container(
            width: size.width > 420 ? 420 : size.width,
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                padding: EdgeInsets.only(
                    top: size.height * .35, left: 40, right: 40),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Your Email Address to Log in",
                      style: AppTextStyles.titleXl,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      lable: 'Email',
                      hint: 'Email Address',
                      controller: _emailController,
                    ),
                    if (_errorMessage !=
                        null) // If there's an error, show error message
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        if (state is SuccessState) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('email', _emailController.value.text);
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
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GestureDetector(
                            onTap: () async {
                              _validateEmail(_emailController.text);
                              if (_errorMessage == null) {
                                // Email is valid, perform the action
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(content: Text('Email is valid')),
                                // );
                                BlocProvider.of<AuthCubit>(context)
                                    .logIn(_emailController.value.text);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.purpleDark,
                                  borderRadius: BorderRadius.circular(10)),
                              width: size.width,
                              child: Text(
                                "login",
                                style: AppTextStyles.titleMediumWhite,
                              ),
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => _handleSignIn(context),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: AppColors.black),
                            color: AppColors.mainBg,
                            borderRadius: BorderRadius.circular(10)),
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/Google.svg"),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Continue with Google",
                              style: AppTextStyles.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                    // The user is NOT Authenticated
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
