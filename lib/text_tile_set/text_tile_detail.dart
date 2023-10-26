import 'package:flutter/material.dart';

class TextTileDetail extends StatefulWidget {
  const TextTileDetail({super.key});

  @override
  State<TextTileDetail> createState() => _TextTileDetailState();
}

class _TextTileDetailState extends State<TextTileDetail> {
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
                                "YYYY/MM/DD",
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
                                  print("press selecting date in calender");
                                },
                                icon: Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ),
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
                    fixedSize: Size(64, 64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    )),
                child: Icon(
                  Icons.add,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
