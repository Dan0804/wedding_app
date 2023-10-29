import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_app/calender_set/calender_service.dart';
part 'calender_detail_tile.dart';

class Calender extends StatefulWidget {
  const Calender({
    super.key,
    required this.textTile,
  });

  final bool textTile;

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final int _year = DateTime.now().year;
  DateTime _today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Events>> events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _today;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalenderService>(
      builder: (context, calenderService, child) => Stack(
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

                return null;
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

                return null;
              },
            ),
            focusedDay: _today,
            firstDay: DateTime.utc(_year - 2),
            lastDay: DateTime.utc(_year + 3),
            onDaySelected: (day, focusedDay) {
              setState(() {
                _selectedDay = day;
                _today = focusedDay;
                if (widget.textTile) {
                  calenderService.addDetailInTile(_selectedDay);
                } else {
                  calenderService.addDetailInPackage(_selectedDay);
                }
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            availableGestures: AvailableGestures.all,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue[500]!.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.purple[200]!.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: calenderService.getEventsForDay,
          ),
          widget.textTile
              ? Positioned(
                  right: 8,
                  bottom: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      calenderService.addEvents(_selectedDay, [Events("${DateTime.now()}")]);
                      if (widget.textTile) {
                        calenderService.addDetailInTile(_selectedDay);
                      } else {
                        calenderService.addDetailInPackage(_selectedDay);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: Size(80, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        )),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
