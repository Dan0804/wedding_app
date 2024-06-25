import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_app/app/screens/main_screen.dart';
import 'package:wedding_app/app/widgets/error_popup.dart';

import '../../util/config.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = Config.apiUrl;
  bool isLoggedIn = false;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    isLoggedIn = token != null;
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
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

        isLoggedIn = true;

        if (!context.mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
          (Route<dynamic> route) => false,
        );

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

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    isLoggedIn = false;
    notifyListeners();
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

      final response = await http.post(
        Uri.parse('$_baseUrl/auth/sign-up'),
        body: json.encode({
          'email': email,
          'password': password,
          'name': name,
          'nickName': 'nickName',
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
        },
      );
    }
  }
}
