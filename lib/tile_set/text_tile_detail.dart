import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/calender_set/calender.dart';

import '../calender_set/calender_service.dart';

class TextTileDetail extends StatefulWidget {
  const TextTileDetail({super.key});

  @override
  State<TextTileDetail> createState() => _TextTileDetailState();
}

class _TextTileDetailState extends State<TextTileDetail> {
  var selectedDay = DateTime(1994, 8, 4);

  void setDate(DateTime selectedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 600,
        minHeight: 200,
      ),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 52.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "제목",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Consumer<CalenderService>(builder: (context, calenderService, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      selectedDay == DateTime(1994, 8, 4) ? "Unselected" : DateFormat("yyyy/MM/dd  EEEE").format(selectedDay),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
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
                                                    SizedBox(
                                                      width: 300,
                                                      height: double.infinity,
                                                      child: CalenderDetail(
                                                        textTile: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) {
                                          if (value == null) {
                                            calenderService.addDetail(DateTime.now(), true);
                                            calenderService.initDateInTile();
                                            return;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.calendar_today),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                calenderService.addEvents(
                                  selectedDay,
                                  [Events("${DateTime.now()}")],
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  fixedSize: Size(60, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  )),
                              child: Icon(
                                Icons.save_rounded,
                                size: 28,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Card(
                      elevation: 5,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 12.0,
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {
                                    value = true;
                                  },
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.black12,
                                    child: SizedBox(
                                      height: 40,
                                      child: Text("checkbox tile"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 56,
              bottom: 32,
              child: ElevatedButton(
                onPressed: () {
                  print("press add checkList button");
                },
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    fixedSize: Size(60, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                child: Icon(
                  Icons.add,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
