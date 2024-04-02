import 'package:flutter/material.dart';
import 'package:wedding_app/widget/calender_tab/calender.dart';

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
                  "Calender",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
          ),
        ],
      ),
    );
  }
}
