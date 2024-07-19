import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_copilet/components/extention.dart';

import '../components/text_style.dart';
import '../res/dimens.dart';

class AppTextField extends StatelessWidget {
  final String lable;
  final String prefixLable;
  final String hint;
  TextEditingController controller;
  final Widget icon;
  final TextAlign textAlign;
  TextInputType? inputType;

  AppTextField(
      {required this.lable,
      required this.hint,
      required this.controller,
      this.icon = const SizedBox(),
      this.prefixLable = '',
      this.textAlign = TextAlign.start,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: size.width,
          child: TextField(
            textAlign: textAlign,
            controller: controller,
            keyboardType: inputType,
            // decoration: new InputDecoration(
            //
            // ),
            decoration: new InputDecoration(
              hintStyle: AppTextStyles.hint,
              hintText: hint,
              prefixIcon: icon,
              border: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0,),
              ),
            ),
          ),
        )
      ],
    );
  }
}
