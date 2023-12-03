import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/calender_set/calender.dart';
import 'package:wedding_app/service_set/tile_service.dart';
import '../service_set/calender_service.dart';

class TextTileDetail extends StatefulWidget {
  const TextTileDetail({
    super.key,
    required this.tileData,
  });

  final Tiles tileData;

  @override
  State<TextTileDetail> createState() => _TextTileDetailState();
}

class _TextTileDetailState extends State<TextTileDetail> {
  late DateTime selectedDay;
  late List<CheckBoxs> checkBoxs;
  bool reset = false;

  void setDate(DateTime selectedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var tileData = widget.tileData;

    if (!reset) {
      selectedDay = tileData.arrangeDate;
      title.text = tileData.title;
      checkBoxs = tileData.checkBoxs;
      reset = true;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 600,
        minHeight: 200,
      ),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Consumer2<CalenderService, TileService>(builder: (context, calenderService, tileService, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 52.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: title,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 28,
                        ),
                        Row(
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
                                      selectedDay == DateTime.utc(1994, 8, 4) ? "Unselected" : DateFormat("yyyy/MM/dd EEEE").format(selectedDay),
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
                                tileService.changeContents(
                                  tileData.tileId,
                                  title.text,
                                  selectedDay,
                                  checkBoxs,
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
                        ),
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
                          itemCount: checkBoxs.length,
                          itemBuilder: (context, index) {
                            TextEditingController boxText = TextEditingController();

                            if (checkBoxs[index].text.isNotEmpty) {
                              boxText.text = checkBoxs[index].text;
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: checkBoxs[index].isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        checkBoxs[index].isChecked = value!;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.black12,
                                      child: SizedBox(
                                        height: 56,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextFormField(
                                              controller: boxText,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                              onChanged: (value) {
                                                checkBoxs[index].text = value;
                                              },
                                            ),
                                          ),
                                        ),
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
              );
            }),
            Positioned(
              right: 56,
              bottom: 32,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    checkBoxs.add(
                      CheckBoxs(false, ""),
                    );
                  });
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
