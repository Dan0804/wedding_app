import 'package:flutter/material.dart';
import 'package:wedding_app/app/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wedding Planner'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Text(
            "당신 옆의 Wedding Planner",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          LoginForm(),
        ],
      ),
    );
  }
}
