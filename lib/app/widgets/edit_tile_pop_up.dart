import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/models/tile.dart';
import 'package:wedding_app/app/services/card/edit_tile_api.dart';
import 'package:wedding_app/calender_set/calender.dart';

class EditTilePopUp extends StatefulWidget {
  final Tile tile;

  const EditTilePopUp({
    super.key,
    required this.tile,
  });

  @override
  State<EditTilePopUp> createState() => _EditTilePopUpState();
}

class _EditTilePopUpState extends State<EditTilePopUp> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _budgetController = TextEditingController();

  late int tileId;
  late String tileTitle;
  late String budget;
  late DateTime deadline;
  late String tileStatus;

  int newBudget = 0;

  void setDate(DateTime selectedDay) {
    setState(() {
      deadline = selectedDay;
    });
  }

  @override
  void initState() {
    super.initState();
    tileId = widget.tile.tileId;
    _titleController.text = widget.tile.tileTitle;
    _budgetController.text = NumberFormat('₩###,###,###,###').format(widget.tile.budget);
    deadline = widget.tile.deadline;
    tileStatus = widget.tile.tileStatus;
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
                    controller: _titleController,
                    onSaved: (value) => tileTitle = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a card title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Budget'),
                    controller: _budgetController,
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

                        newBudget = int.parse(budgetStr);
                      } else {
                        newBudget = 0;
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
                    child: Consumer<EditTileApi>(builder: (context, editTileApi, child) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            bool isSuccess = await editTileApi.editTile(
                              tileId,
                              _titleController.text,
                              newBudget,
                              deadline,
                              tileStatus,
                            );
                            if (isSuccess) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Edit Created Successfully!')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to Edit Card')),
                              );
                            }
                          }
                        },
                        child: Text('카드 수정!'),
                      );
                    }),
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
