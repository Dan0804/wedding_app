import 'package:flutter/material.dart';

class PartnerEnterPopUp extends StatefulWidget {
  const PartnerEnterPopUp({super.key});

  @override
  State<PartnerEnterPopUp> createState() => _PartnerEnterPopUpState();
}

class _PartnerEnterPopUpState extends State<PartnerEnterPopUp> {
  final _formKey = GlobalKey<FormState>();
  final _partnerEmailController = TextEditingController();
  final _partnerCertiController = TextEditingController();

  var showPartnerCerti = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('파트너 등록하기(선택사항)'),
      ),
      content: SizedBox(
        height: 300,
        width: 450,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: _partnerEmailController,
                      decoration: InputDecoration(labelText: '파트너 Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이메일을 입력해주세요!';
                        } else if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                          return '이메일 형식이 틀립니다.';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showPartnerCerti = true;
                          setState(() {});
                        }
                      },
                      child: Text('인증 요청'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              showPartnerCerti
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: _partnerCertiController,
                            decoration: InputDecoration(labelText: '인증 코드'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '인증 코드를 입력해주세요!';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text('인증 확인'),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      actions: [
        Column(
          children: [
            Text(
              '※ 나중에라도 입력할 수 있어요!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text('등록하기'),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('건너뛰기'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
