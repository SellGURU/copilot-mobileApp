import 'package:flutter/material.dart';
import '../components/text_style.dart';
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert' show json;

class AppTextField extends StatefulWidget {
  final String lable;
  final String prefixLable;
  final String hint;
  TextEditingController controller;
  final Widget icon;
  final TextAlign textAlign;
  TextInputType? inputType;
  final String? errorText; // This will hold the error message
  bool isPassword;

  AppTextField({
    required this.lable,
    required this.isPassword,
    required this.hint,
    required this.controller,
    this.icon = const SizedBox(),
    this.prefixLable = '',
    this.textAlign = TextAlign.start,
    this.inputType,
    this.errorText, // Pass errorText here
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width,
          child: TextFormField(
            textAlign: widget.textAlign,
            controller: widget.controller,
            keyboardType: widget.inputType,
            // Add the error message to the InputDecoration
            decoration: InputDecoration(
              hintStyle: AppTextStyles.hint,
              hintText: widget.hint,
              prefixIcon: widget.icon,
              errorStyle: AppTextStyles.hint,
              errorText: widget.errorText, // Display the error message here
              border: widget.errorText == null
                  ? const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    )
                  : const OutlineInputBorder(
                      // This ensures the border turns red when there's an error
                      borderSide: BorderSide(color: Colors.red, width: 6.5),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
