import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../res/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle title1 =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 16, color: AppColors.text,fontWeight: FontWeight.w500));
  static TextStyle whiteTitle1 = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 16, color: Colors.white, ));
  static TextStyle title2 =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 14, color: AppColors.text));
  static TextStyle hint = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.textLite));

}