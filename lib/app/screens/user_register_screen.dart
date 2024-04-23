import 'package:flutter/material.dart';
import 'package:wedding_app/app/widgets/register_form.dart';

class UserRegisterScreen extends StatelessWidget {
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
            "회원가입",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          RegisterForm(),
        ],
      ),
    );
  }
}
