import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_app/app/widgets/error_popup.dart';

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

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var url = Uri.http("49.50.163.210:8080", '/api/v1/auth/login');
      final response = await http.post(
        url,
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
      } else {
        final decodedBody = utf8.decode(response.bodyBytes);
        if (!context.mounted) return;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorPopUp(
                error: decodedBody.toString(),
              );
            });
      }
    } on Exception catch (error) {
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorPopUp(
              error: error.toString(),
            );
          });
    } catch (error) {
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorPopUp(
              error: error.toString(),
            );
          });
    }
  }

  Future<void> register(
    String email,
    String password,
    String name,
    String partnerEmail,
    BuildContext context,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var url = Uri.http("49.50.163.210:8080", '/api/v1/auth/sign-up');
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'name': name,
          'nickName': '',
          'partnerEmail': partnerEmail,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
          'Accept': '*/*',
        },
      );

      if (response.statusCode == 201) {
        if (!context.mounted) return;
        Navigator.pop(context);
        notifyListeners();
      } else {
        final decodedBody = utf8.decode(response.bodyBytes);
        if (!context.mounted) return;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorPopUp(
                error: decodedBody.toString(),
              );
            });
      }
    } on Exception catch (error) {
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorPopUp(
              error: error.toString(),
            );
          });
    } catch (error) {
      if (!context.mounted) return;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorPopUp(
              error: error.toString(),
            );
          });
    }
  }
}
