import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../res/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle title1 =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 16, color: AppColors.text,fontWeight: FontWeight.w500));
  static TextStyle whiteTitle1 = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500));
  static TextStyle titleSmale = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500));
  static TextStyle titleMedium = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400));
  static TextStyle title2 =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 14, color: AppColors.text),fontWeight: FontWeight.w500);
  static TextStyle hint = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.textLite,fontWeight: FontWeight.w400));
  static TextStyle hintWhite = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500));
  static TextStyle hintSmale = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 10, color: AppColors.textLite));
  static TextStyle gradeGreen = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 11,fontWeight: FontWeight.w500, color: AppColors.greenBega));
  static TextStyle gradeRed = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 11,fontWeight: FontWeight.w500, color: Colors.red));
  static TextStyle gradeYellow = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 11,fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 228, 94, 1)));

}