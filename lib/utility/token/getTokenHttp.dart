import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getTokenHttp(String username, String password) async {
  final response = await http.post(
      Uri.parse('http://51.142.20.137:5052/auth/token'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': '',
        'username': username,
        'password': password,
        'scope': '',
        'client_id': '',
        'client_secret': ''
      });

  if (response.statusCode == 200) {
    // Assuming your backend returns a JSON object with a boolean 'isValid' field
    final responseBody = json.decode(response.body);
    return responseBody['access_token'];
  } else {
    print("error in get token:${response.statusCode}");
    return "null";
  }
}
