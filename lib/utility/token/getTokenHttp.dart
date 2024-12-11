/// This file defines a function to retrieve an access token from a backend API using HTTP POST.
/// It sends user credentials (username and password) to an authentication endpoint and retrieves a token.

import 'package:http/http.dart' as http;
import 'dart:convert';

/// Function to get an access token by sending a POST request with username and password.
///
/// The function interacts with the authentication endpoint and expects a successful response
/// containing an access token. If the response is successful, it extracts the token from the response body.
///
/// **Parameters:**
/// - [username]: The username to authenticate.
/// - [password]: The password to authenticate.
///
/// **Returns:**
/// - A [String] containing the access token if the request is successful.
///
/// **Throws:**
/// - An [Exception] if the request fails (non-200 HTTP status).
Future<String> getTokenHttp(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://51.142.20.137:5052/'), // API endpoint for authentication
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded', // Content type for the POST request
    },
    body: {
      'grant_type': '', // Empty grant type, should be filled in for OAuth2.0
      'username': username, // Provided username
      'password': password, // Provided password
      'scope': '', // Empty scope, could be configured based on requirements
      'client_id': '', // Empty client ID, should be specified for OAuth2.0
      'client_secret': '' // Empty client secret, should be specified for OAuth2.0
    },
  );

  // If the request is successful (HTTP status 200)
  if (response.statusCode == 200) {
    // Parse the JSON response body
    final responseBody = json.decode(response.body);
    // Return the 'access_token' from the response body
    return responseBody['access_token'];
  } else {
    // If the request fails, print the error and throw an exception
    print("Error in get token: ${response.statusCode}");
    throw Exception('Failed to retrieve token');
  }
}
