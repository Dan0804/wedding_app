import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    _isLoggedIn = token != null;
    notifyListeners();

    return _isLoggedIn;
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = "localhost:8080";
    final response = await http.post(
      Uri.http(url, '/api/v1/auth/login'),
      body: json.encode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
        'Accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];

      // 토큰을 로컬 스토리지에 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      _isLoggedIn = true;
      notifyListeners();

      if (kDebugMode) {
        print('Login successful');
        print('loginApi Token: $token');
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
