import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 500,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Card Title'),
                onSaved: (value) => cardTitle = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a card title';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 500,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Budget'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, CurrencyTextInputFormatter(enableNegative: false, locale: 'ko', symbol: 'KRW ')],
                onSaved: (value) => budget = int.tryParse(value!) ?? 0,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text("Deadline"),
                    Icon(Icons.calendar_month),
                  ],
                )),
            SizedBox(
              height: 30,
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
