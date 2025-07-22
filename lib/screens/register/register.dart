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
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

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
  bool _acceptTerms = false;

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
      } else if (value.length < 8) {
        _errorMessagePassword = 'Password must be at least 8 characters long';
      } else if (!RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]')
          .hasMatch(value)) {
        _errorMessagePassword =
            'Password must include uppercase, lowercase, numbers and special characters';
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
        if (_errorMessagePassword == null &&
            _errorMessageConfirmPassword == null &&
            _acceptTerms) {
          _registerUser();
        } else if (!_acceptTerms) {
          Fluttertoast.showToast(
            msg: "Please accept the privacy policy and terms of service",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
        break;
    }
  }

  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Could not open the link",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
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
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          "assets/loginElips.svg",
                          height: 200,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: (size.width > 420 ? 130 : size.width / 2 - 66),
                          top: 100,
                          child: Container(
                            width: 132,
                            height: 132,
                            child: Image.asset("assets/logoH.png"),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.mainPrimaryColor,
                                width: 2, // Adjust border thickness as needed
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 24, top: 36),
                      child: Column(
                        children: [
                          Text(
                            'Welcome to HolistiCare!',
                            style: AppTextStyles.title1,
                          ),
                          const SizedBox(height: 64),
                          Text(
                            _currentStep == 0
                                ? "We're excited to have you join our community. Please enter your email address to create your account.​"
                                : "Set a password. It must be strong to ensure your security.",
                            style: AppTextStyles.hintTextPrimaryWithHeight,
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
                              onChanged: _validateEmail,
                            ),
                          if (_currentStep == 1) ...[
                            AppTextField(
                              label: 'Password',
                              hint: 'Enter your password ....',
                              controller: _passwordController,
                              isPassword: true,
                              errorText: _errorMessagePassword,
                              onChanged: _validatePassword,
                              tooltipMessage:
                                  'At least 8 characters.\n(Use Uppercase & Lowercase letters, Numbers and Special characters).\nAvoid using personal information or patterns.',
                            ),
                            const SizedBox(height: 20),
                            AppTextField(
                              label: 'Confirm Password',
                              hint: 'Confirm your password ...',
                              controller: _confirmPasswordController,
                              isPassword: true,
                              errorText: _errorMessageConfirmPassword,
                              onChanged: _validateConfirmPassword,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Checkbox(
                                  value: _acceptTerms,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _acceptTerms = value ?? false;
                                    });
                                  },
                                  activeColor: AppColors.primaryDeepTeal,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _acceptTerms = !_acceptTerms;
                                      });
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        style:
                                            AppTextStyles.titleMedium.copyWith(
                                          color: const Color(0xFF888888),
                                          fontSize: 12,
                                        ),
                                        children: [
                                          const TextSpan(text: 'I accept the '),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: AppColors.primaryDeepTeal,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(
                                                    'https://holisticare.io/privacy-policy/');
                                              },
                                          ),
                                          const TextSpan(text: ' and '),
                                          TextSpan(
                                            text: 'Terms of Service',
                                            style: TextStyle(
                                              color: AppColors.primaryDeepTeal,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                _launchURL(
                                                    'https://holisticare.io/terms-of-service/');
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 64),
                          GestureDetector(
                            onTap: _isLoading ? null : _handleContinue,
                            child: Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: _isLoading
                                    ? AppColors.primaryDeepTeal.withOpacity(0.7)
                                    : AppColors.primaryDeepTeal,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1, // 1px
                                ),
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
                                      _currentStep == 1
                                          ? "Sign Up"
                                          : "Continue",
                                      style: AppTextStyles.titleMediumWhite,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (_currentStep == 0)
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
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: const Color(0xFF888888),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Log in",
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: AppColors.primaryDeepTeal,
                                      fontSize: 12,
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
