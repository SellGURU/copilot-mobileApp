import 'package:shared_preferences/shared_preferences.dart';

Future<void> UpdateToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

Future<void> UpdateEncode(String encode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('encode', encode);
}