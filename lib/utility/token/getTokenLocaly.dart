import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getTokenLocally() async {
  print("getTokenLocally");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
