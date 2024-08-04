import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> validateToken(String token) async {
  final response = await http.post(
    Uri.parse('https://your-backend.com/validate-token'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Assuming your backend returns a JSON object with a boolean 'isValid' field
    final responseBody = json.decode(response.body);
    return responseBody['isValid'];
  } else {
    return false;
  }
}
