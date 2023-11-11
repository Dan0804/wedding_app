import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/service_set/tile_service.dart';
import 'package:wedding_app/tile_set/tile_form.dart';

class ToDoListPackage extends StatefulWidget {
  const ToDoListPackage({super.key});

  @override
  State<ToDoListPackage> createState() => _ToDoListPackageState();
}

class _ToDoListPackageState extends State<ToDoListPackage> {
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
                child: Consumer<TileService>(builder: (context, tileService, child) {
                  var beforeList = tileService.sortedList(0);
                  var doingList = tileService.sortedList(1);
                  var doneList = tileService.sortedList(2);
                  return Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: SizedBox(
                          height: double.infinity,
                          child: Column(
                            children: [
                              smallTitle("Before"),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: ListView.builder(
                                    itemCount: beforeList.length,
                                    itemBuilder: (context, index) {
                                      return TileForm(tileData: beforeList[index]);
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
                              smallTitle("Doing"),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: ListView.builder(
                                    itemCount: doingList.length,
                                    itemBuilder: (context, index) {
                                      return TileForm(tileData: doingList[index]);
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
                              smallTitle("Done"),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: ListView.builder(
                                    itemCount: doneList.length,
                                    itemBuilder: (context, index) {
                                      return TileForm(tileData: doneList[index]);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
