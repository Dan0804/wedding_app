import 'package:flutter/material.dart';
import 'package:wedding_app/app/widgets/forCalender/calender.dart';

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
              Stack(
                children: [
                  Calender(
                    setDate: null,
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CalenderDetail(
                    textTile: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
