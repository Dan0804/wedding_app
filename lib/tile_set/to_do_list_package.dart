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
  Widget tileColumn(String title, int status) {
    return Consumer<TileService>(builder: (context, tileService, child) {
      var dataList = tileService.sortedList(status);
      return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Padding(
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
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return TileForm(tileData: dataList[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

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
          Consumer<TileService>(builder: (context, tileService, child) {
            tileService.collectEvents();
            return Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  child: Row(
                    children: [
                      tileColumn("Before", 0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                          ),
                        ),
                      ),
                      tileColumn("Doing", 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                          ),
                        ),
                      ),
                      tileColumn("Done", 2),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
