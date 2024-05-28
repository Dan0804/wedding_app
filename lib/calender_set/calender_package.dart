import 'package:flutter/material.dart';
import 'package:wedding_app/calender_set/calender.dart';

class CalenderPackage extends StatefulWidget {
  const CalenderPackage({super.key});

  @override
  State<CalenderPackage> createState() => _CalenderPackageState();
}

class _CalenderPackageState extends State<CalenderPackage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Card(
          elevation: 10,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Calender",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Stack(
                    children: [
                      Calender(
                        textTile: false,
                        setDate: null,
                      ),
                      Positioned(
                        top: 12,
                        right: 64,
                        child: IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(Icons.refresh),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CalenderDetail(
                    textTile: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
