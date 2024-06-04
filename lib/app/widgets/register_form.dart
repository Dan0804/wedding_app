import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailCertiController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final _nameController = TextEditingController();
  final _partnerEmailController = TextEditingController();

  var showEmailCerti = false;
  var showRegisterForm = false;

  Widget extraForm(BuildContext context) {
    return Column(
      children: [
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
              if (value != _passwordController.text) {
                return 'Password랑 틀려요!';
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
              if (value == '') {
                return null;
              } else if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value!)) {
                return '이메일 형식이 틀립니다.';
              }
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: '가입 Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일이 비어있어요!';
                      } else if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                        return '이메일 형식이 틀립니다.';
                      }
                      return null;
                    },
                    readOnly: showRegisterForm ? true : false,
                  ),
                ),
                showRegisterForm
                    ? Container()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showEmailCerti = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('인증 코드를 보냈어요!')),
                            );
                            setState(() {});
                          }
                        },
                        child: Text('인증 요청'),
                      ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            showEmailCerti
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _emailCertiController,
                          decoration: InputDecoration(labelText: '인증 코드'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '인증 코드를 입력해주세요!';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showRegisterForm = true;
                            showEmailCerti = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('이메일 인증에 성공했어요. 나머지 정보를 입력해주세요!')),
                            );
                            setState(() {});
                          }
                        },
                        child: Text('인증 확인'),
                      ),
                    ],
                  )
                : Container(),
            showRegisterForm ? extraForm(context) : Container(),
          ],
        ),
      ),
    );
  }
}
