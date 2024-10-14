import 'package:copilet/components/text_style.dart';
import 'package:copilet/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../res/colors.dart';

class Welcomscreen extends StatefulWidget {
  const Welcomscreen({super.key});

  @override
  State<Welcomscreen> createState() => _WelcomscreenState();
}

class _WelcomscreenState extends State<Welcomscreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/splashWeb.svg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logoIcon.png"),
                Text("Welcome to LPC!", style: AppTextStyles.title3xl),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: 350,
                    child: Text(
                      "If you received an invitation email, please click the button below.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.whiteTitle1,
                    )),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    margin:  EdgeInsets.symmetric(horizontal: size.width/10),
                    decoration: BoxDecoration(
                        color: AppColors.purpleDark,
                        borderRadius: BorderRadius.circular(10)),
                    width: size.width,
                    child: Text(
                      "Continue",
                      style: AppTextStyles.hintWhite,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 350,
                    child: Text(
                      "Holisticare is an invite-only app. You’ll need an invitation email from LPC to create an account.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.hintWhite,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
