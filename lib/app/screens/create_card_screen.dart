import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/card/create_card_api.dart';

class CreateCardScreen extends StatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String cardTitle = '';
  int budget = 0;
  DateTime? deadline;
  // Instance of your ApiService
  final CreateCardApi _apiService = CreateCardApi();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool isSuccess = await _apiService.createCard(cardTitle, budget, deadline as DateTime);
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Card Created Successfully!')),
        );
        // Optionally, navigate back or to another screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Create Card')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Card'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Card Title'),
              onSaved: (value) => cardTitle = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a card title';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Budget'),
              keyboardType: TextInputType.number,
              onSaved: (value) => budget = int.tryParse(value!) ?? 0,
              validator: (value) {
                if (value == null || value.isEmpty || int.tryParse(value) == null) {
                  return 'Please enter a valid budget';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Deadline (yyyy-MM-dd)'),
              onSaved: (value) => deadline = DateFormat('yyyy-MM-dd').parse(value!),
              validator: (value) {
                // Implement your own validation logic (e.g., check for valid date format)
                if (value == null || value.isEmpty) {
                  return 'Please enter a deadline';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Create Card'),
            ),
          ],
        ),
      ),
    );
  }
}
