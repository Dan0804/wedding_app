import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:wedding_app/calender_set/calender.dart';
import '../services/card/create_card_api.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  late DateTime selectedDay;
  final _formKey = GlobalKey<FormState>();
  String cardTitle = '';
  int budget = 0;
  DateTime? deadline;
  // Instance of your ApiService
  final CreateCardApi _apiService = CreateCardApi();

  void setDate(DateTime selectedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

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
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, CurrencyTextInputFormatter.currency(enableNegative: false, locale: 'ko', symbol: 'KRW ')],
                  onSaved: (value) => budget = int.tryParse(value!) ?? 0,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                content: SizedBox(
                                  height: 400,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        width: 400,
                                        child: Calender(
                                          textTile: true,
                                          setDate: setDate,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black45),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: SizedBox(
                                          width: 300,
                                          height: double.infinity,
                                          child: CalenderDetail(
                                            textTile: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Deadline"),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.calendar_month,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "yyyy-mm-dd",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Create Card'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
