import 'package:flutter/material.dart';
import 'package:wedding_app/text_tile_set/doing_text_tile.dart';
import 'package:wedding_app/text_tile_set/before_text_tile.dart';
import 'package:wedding_app/text_tile_set/end_text_tile.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Widget smallTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 5,
        child: SizedBox(
          height: 36,
          width: 128,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Text(
                  "To Do List",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          children: [
                            smallTitle("진행 전"),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return BeforeTextTile();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          children: [
                            smallTitle("진행 중"),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: ListView.builder(
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return DoingTextTile();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      flex: 1,
                      fit: FlexFit.tight,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          children: [
                            smallTitle("진행 완료"),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return EndTextTile();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
