import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../res/colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static TextStyle title3xl =GoogleFonts.alice( textStyle:TextStyle(fontSize: 32, color: AppColors.mainBg,fontWeight: FontWeight.w700));

  static TextStyle title2xl =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 24, color: AppColors.text,fontWeight: FontWeight.w700));
  static TextStyle titleXl =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 20, color: AppColors.text,fontWeight: FontWeight.w500));

  // --------------

  static TextStyle title1 =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 16, color: AppColors.text,fontWeight: FontWeight.w500));
  static TextStyle titleLg =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 16, color: AppColors.text,fontWeight: FontWeight.w400));
  static TextStyle whiteTitle1 = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500));
  // --------------

  static TextStyle titleMedium = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 14, color: AppColors.black, fontWeight: FontWeight.w400));
  static TextStyle titleMediumHeight = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 14, color: AppColors.black, fontWeight: FontWeight.w400,height: 1.2));
  static TextStyle titleMediumWhite = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400));
  static TextStyle title2 =GoogleFonts.roboto( textStyle:TextStyle(fontSize: 14, color: AppColors.text),fontWeight: FontWeight.w500);
  // -----------
  static TextStyle hintBlackWithHeight = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.black,fontWeight: FontWeight.w400,height: 2));
  static TextStyle hintWhite = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500));
  static TextStyle hintMedium = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.black,fontWeight: FontWeight.w500));
  static TextStyle hintBlack = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.black,fontWeight: FontWeight.w400));
  static TextStyle hint = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.textLite,fontWeight: FontWeight.w400));
  static TextStyle hintPurple = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.purpleDark,fontWeight: FontWeight.w400));
  static TextStyle hintLitePurple = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 12, color: AppColors.purpleLite,fontWeight: FontWeight.w400));
  // --------------

  static TextStyle gradeGreen = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 11,fontWeight: FontWeight.w500, color: AppColors.greenBega));
  static TextStyle gradeRed = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 11,fontWeight: FontWeight.w500, color: Color.fromRGBO(255, 116, 128, 1)));
  static TextStyle gradeYellow = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 11,fontWeight: FontWeight.w500, color: Color.fromARGB(255,255, 228, 94)));

  // --------------
  static TextStyle hintSmale = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 10, color: AppColors.textLite, fontWeight: FontWeight.w400));
  static TextStyle hintSmaleLite = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 10, color: AppColors.hintLite, fontWeight: FontWeight.w400));
  static TextStyle titleSmaleBold = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 10, color: AppColors.black, fontWeight: FontWeight.w500));
  // --------------

  static TextStyle hintVerySmale = GoogleFonts.roboto( textStyle:TextStyle(fontSize: 8, color: AppColors.hintLite,fontWeight: FontWeight.w400));
}