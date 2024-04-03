import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {

  Future<void> login(String email, String password) async {
    String url = "localhost:8080";
    final response = await http.post(
      Uri.http(url, '/api/v1/users/login'),
      body: json.encode({
        'email': email,
        'password': password,
      }),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Login successful');
      }
    } else {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonBody = json.decode(decodedBody);

      throw Exception(
              'Login failed: '
              'Status code: ${response.statusCode} '
              'Response body: $jsonBody'
      );
    }
  }
}
