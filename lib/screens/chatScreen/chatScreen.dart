import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_copilet/widgets/text_field.dart';

import '../../components/text_style.dart';
import '../../res/colors.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * .02),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "AI Copilot",
                    style: AppTextStyles.title1,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_none_outlined,
                        color: AppColors.purpleDark,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        "assets/notificationIcon.svg",
                        width: 25,
                        height: 25,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            width: size.width * .9,
            child: Container(
              alignment: Alignment.center,
              height: 44,
              width: size.width * .8,
              child: Material(
                color: AppColors.mainBg,
                elevation: 15,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                shadowColor: AppColors.mainShadow,
                child: TextField(
                  textAlign: TextAlign.left,
                  // controller: controller,
                  // keyboardType: inputType,
                  // decoration: new InputDecoration(
                  //
                  // ),

                  decoration: InputDecoration(
                    hintStyle: AppTextStyles.hint,
                    hintText: "Ask me anything...",
                    prefixIcon: const Icon(Icons.access_alarm),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
