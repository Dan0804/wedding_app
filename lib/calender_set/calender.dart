import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_app/calender_set/events.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  int year = DateTime.now().year;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  Map<DateTime, List<Events>> events = {};

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
                            TableCalendar(
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  if (day.weekday == DateTime.saturday) {
                                    final text = day.day.toString();

                                    return Center(
                                      child: Text(
                                        text,
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    );
                                  }

                                  if (day.weekday == DateTime.sunday) {
                                    final text = day.day.toString();

                                    return Center(
                                      child: Text(
                                        text,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  }
                                },
                                dowBuilder: (context, day) {
                                  if (day.weekday == DateTime.sunday) {
                                    final text = DateFormat.E().format(day);

                                    return Center(
                                      child: Text(
                                        text,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  }

                                  if (day.weekday == DateTime.saturday) {
                                    final text = DateFormat.E().format(day);

                                    return Center(
                                      child: Text(
                                        text,
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    );
                                  }
                                },
                              ),
                              focusedDay: focusedDay,
                              firstDay: DateTime.utc(year - 1),
                              lastDay: DateTime.utc(year + 3),
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  this.focusedDay = selectedDay;
                                });
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(selectedDay, day);
                              },
                              availableGestures: AvailableGestures.all,
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                              ),
                              // calendarStyle: CalendarStyle(
                              //   todayDecoration: BoxDecoration(
                              //     color: Colors.blue[500],
                              //     shape: BoxShape.rectangle,
                              //     borderRadius: BorderRadius.circular(12.0),
                              //   ),
                              // ),
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              color: Colors.black12,
                              child: SizedBox(
                                height: 64,
                                child: Center(
                                  child: Text("calender details"),
                                ),
                              ),
                            );
                          },
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
