import 'package:copilet/components/text_style.dart';
import 'package:copilet/screens/register/register.dart';
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
    return Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        child: Container(
          width: size.width > 420 ? 420 : size.width,
          child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/splashWeb2.svg",
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/logoIcon.png"),
                      Text("Clinic Logo",
                          style: AppTextStyles.title4xlLiteWeight),
                      Text("Welcome to Our Clinic!",
                          style: AppTextStyles.title3xlLiteWeight),
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
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          width: 350,
                          // margin:
                          //     EdgeInsets.symmetric(horizontal: size.width / 10),
                          decoration: BoxDecoration(
                              color: AppColors.purpleDark,
                              borderRadius: BorderRadius.circular(20)),
                          // width: size.width,
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
                            "Holisticare is an invite-only app. You'll need an invitation email from LPC to create an account.",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.hintWhite,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
