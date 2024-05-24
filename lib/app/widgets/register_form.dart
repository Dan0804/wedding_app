import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final _nameController = TextEditingController();
  final _partnerEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '가입 Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일이 비어있어요!';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '가입 Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호가 비어있어요!';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _passwordCheckController,
              decoration: InputDecoration(labelText: 'Password 확인'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password 확인해주세요!';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '성명'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름 칸이 비어있어요!';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _partnerEmailController,
              decoration: InputDecoration(labelText: 'Partner Email (나중에 입력해도 되요!)'),
              validator: (value) {
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('가입할게요!'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<AuthService>(context, listen: false).register(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      _partnerEmailController.text,
                      context,
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
