import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/screens/main_screen.dart';
import 'package:wedding_app/app/services/tile_service.dart';
import 'package:wedding_app/calender_set/calender.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key});

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String cardTitle = '';
  int budget = 0;
  DateTime deadline = DateTime(1994, 8, 4);

  void setDate(DateTime selectedDay) {
    setState(() {
      deadline = selectedDay;
    });
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyTextInputFormatter.currency(locale: 'ko', decimalDigits: 0, symbol: '₩'),
                  ],
                  onSaved: (value) {
                    if (value != '') {
                      var removeCurrency = value!.split('₩');
                      var removeRest = removeCurrency[1].split(',');
                      String budgetStr = '';

                      for (int i = 0; i < removeRest.length; i++) {
                        budgetStr = budgetStr + removeRest[i];
                      }

                      budget = int.parse(budgetStr);
                    } else {
                      budget = 0;
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 140,
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
                      deadline == DateTime(1994, 8, 4) ? '미정' : DateFormat('yyyy년 MM월 dd일 (E)', 'ko').format(deadline),
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 150,
                  child: Consumer<TileService>(builder: (context, tileService, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bool isSuccess = await tileService.createCard(cardTitle, budget, deadline);
                          if (isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Card Created Successfully!')),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to Create Card')),
                            );
                          }
                        }
                      },
                      child: Text('Create Card'),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
