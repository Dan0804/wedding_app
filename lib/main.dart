import 'package:flutter/material.dart';
import 'package:wedding_app/calender_set/calender.dart';
import 'package:wedding_app/to_do_list.dart';

void main() {
  runApp(const WeddingApp());
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Center(
            child: Text(
              "Our Wedding Diary",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          actions: [
            Icon(
              Icons.person,
              color: Colors.black,
              size: 32,
            ),
            Icon(
              Icons.settings,
              color: Colors.black,
              size: 32,
            ),
            SizedBox(
              width: 32,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 64,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0.3,
                  minHeight: 24,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Row(
                children: [
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: ToDoList(),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Calender(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
