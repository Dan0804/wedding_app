import 'package:flutter/material.dart';

class ErrorPopUp extends StatelessWidget {
  final String error;

  const ErrorPopUp({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error 발생'),
      content: Text(error),
      actions: <Widget>[
        TextButton(
          child: const Text('닫기'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
