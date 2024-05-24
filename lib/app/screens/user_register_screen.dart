import 'package:flutter/material.dart';
import 'package:wedding_app/app/widgets/register_form.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wedding Planner'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "회원가입!",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RegisterForm(),
        ],
      ),
    );
  }
}
