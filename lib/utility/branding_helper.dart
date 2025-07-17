import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/branding_data.dart';

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) hex = 'FF$hex';
  return Color(int.parse(hex, radix: 16));
}

Future<void> cacheBrandingData(BrandingData data) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(
      'branding_data',
      jsonEncode({
        'title': data.title,
        'slogan': data.slogan,
        'primaryColorHex': data.primaryColorHex,
      }));
}

Future<BrandingData?> getCachedBrandingData() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('branding_data');
  if (jsonString != null) {
    return BrandingData.fromJson(jsonDecode(jsonString));
  }
  return null;
}
