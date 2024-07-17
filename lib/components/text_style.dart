import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../res/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final TextStyle title1 =GoogleFonts.roboto( textStyle:   TextStyle(fontSize: 16, color: AppColors.text,fontWeight: FontWeight.w500));
  static final TextStyle whiteTitle1 = GoogleFonts.roboto( textStyle:  TextStyle(fontSize: 16, color: Colors.white, ));
  static final TextStyle title2 =GoogleFonts.roboto( textStyle:  TextStyle(fontSize: 14, color: AppColors.text));
  static final TextStyle hint = GoogleFonts.roboto( textStyle:  TextStyle(fontSize: 12, color: AppColors.textLite));

}