import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getTokenLocally() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
