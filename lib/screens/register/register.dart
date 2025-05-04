import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/constants/endPoints.dart';
import 'package:copilet/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:copilet/screens/login/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  int _currentStep = 0;
  String? _errorMessageEmail;
  String? _errorMessagePassword;
  String? _errorMessageConfirmPassword;
  bool _isLoading = false;

  void _validateEmail(String value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(pattern);

    setState(() {
      if (value.isEmpty) {
        _errorMessageEmail = 'Please enter an email';
      } else if (!regExp.hasMatch(value)) {
        _errorMessageEmail = 'Please enter a valid email';
      } else {
        _errorMessageEmail = null;
      }
    });
  }

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorMessagePassword = 'Please enter a password';
      } else if (value.length < 6) {
        _errorMessagePassword = 'Password must be at least 6 characters long';
      } else {
        _errorMessagePassword = null;
      }
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _errorMessageConfirmPassword = 'Please confirm your password';
      } else if (value != _passwordController.text) {
        _errorMessageConfirmPassword = 'Passwords do not match';
      } else {
        _errorMessageConfirmPassword = null;
      }
    });
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(Endpoints.register),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful registration
        Fluttertoast.showToast(
          msg: "Registration successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Navigate to login page
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        // Handle error response
        String errorMessage = "Registration failed";
        if (responseData['message'] != null) {
          errorMessage = responseData['message'];
        } else if (responseData['errors'] != null) {
          errorMessage = responseData['errors'].toString();
        }
        
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } on http.ClientException {
      Fluttertoast.showToast(
        msg: "Network error. Please check your connection.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleContinue() {
    switch (_currentStep) {
      case 0:
        _validateEmail(_emailController.text);
        if (_errorMessageEmail == null) {
          setState(() {
            _currentStep = 1;
          });
        }
        break;
      case 1:
        _validatePassword(_passwordController.text);
        _validateConfirmPassword(_confirmPasswordController.text);
        if (_errorMessagePassword == null && _errorMessageConfirmPassword == null) {
          _registerUser();
        }
        break;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                          "assets/loginElips.svg",
                          height: 200,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: (size.width > 420 ? 130 : size.width / 2 - 100),
                          top: 100,
                          child: Text("Clinic Logo", style: AppTextStyles.title4xlLiteWeight,)
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 24, top: 36),
                      child: Column(
                        children: [
                          Text('Welcome to HolistiCare!', style: AppTextStyles.title1,),
                          const SizedBox(height: 64),
                          Text(
                            _currentStep == 0
                                ? "We're excited to have you join our community. Please enter your email address to create your account.​"
                                : "Set a password. It must be strong to ensure your security.",
                            style: AppTextStyles.hintBlackWithHeight,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          if (_currentStep == 0)
                            AppTextField(
                              label: 'Email',
                              hint: 'Enter your email ...',
                              controller: _emailController,
                              isPassword: false,
                              errorText: _errorMessageEmail,
                            ),
                          if (_currentStep == 1) ...[
                            AppTextField(
                              label: 'Password',
                              hint: 'Enter Password',
                              controller: _passwordController,
                              isPassword: true,
                              errorText: _errorMessagePassword,
                            ),
                            const SizedBox(height: 20),
                            AppTextField(
                              label: 'Confirm Password',
                              hint: 'Confirm your Password',
                              controller: _confirmPasswordController,
                              isPassword: true,
                              errorText: _errorMessageConfirmPassword,
                            ),
                          ],
                          const SizedBox(height: 64),
                          GestureDetector(
                            onTap: _isLoading ? null : _handleContinue,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: _isLoading ? AppColors.greenBega.withOpacity(0.7) : AppColors.greenBega,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              width: size.width,
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      _currentStep == 1 ? "Sign Up" : "Continue",
                                      style: AppTextStyles.titleMediumWhite,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: AppTextStyles.titleMedium,
                                ),
                                Text(
                                  "login",
                                  style: AppTextStyles.titleMedium.copyWith(
                                    color: AppColors.greenBega,
                                  ),
                                ),
                              ],
                            ),
                          ),
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