import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wedding_app/calender_set/calender.dart';

class EditTilePopUp extends StatefulWidget {
  const EditTilePopUp({super.key});

  @override
  State<EditTilePopUp> createState() => _EditTilePopUpState();
}

class _EditTilePopUpState extends State<EditTilePopUp> {
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
    return AlertDialog(
      title: Center(
        child: Text('Card 수정 Page'),
      ),
      content: SizedBox(
        height: 300,
        width: 400,
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
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
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: Text('카드 수정!'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
