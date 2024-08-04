import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> getTokenHttp(String username, String password) async {
  final response =
      await http.post(Uri.parse('http://51.142.20.137:5052/auth/token'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            "grant_type":"",
            "username": "amin75t",
            "password": "1",
            "scope": "",
            "client_id": "",
            "client_secret": ""
          }));

  if (response.statusCode == 200) {
    // Assuming your backend returns a JSON object with a boolean 'isValid' field
    // final responseBody = json.decode(response.body);
    // return responseBody['isValid'];
    print(response.body);
    return true;
  } else {
    print(response.statusCode);

    return false;
  }
}
