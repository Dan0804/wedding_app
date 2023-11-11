import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wedding_app/service_set/calender_service.dart';
part 'calender_detail_tile.dart';

class Calender extends StatefulWidget {
  const Calender({
    super.key,
    required this.textTile,
    required this.setDate,
  });

  final bool textTile;
  final Function? setDate;

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final int _year = DateTime.now().year;
  DateTime _today = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = _today;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _eventsMarker(List events, DateTime day, DateTime selectedDay) {
    return Align(
      alignment: day == selectedDay ? Alignment(0.6, 0.6) : Alignment(0.5, 0.5),
      child: CircleAvatar(
        radius: 8,
        backgroundColor: Colors.red[300],
        child: Center(
          child: Text(
            "${events.length}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalenderService>(
      builder: (context, calenderService, child) => Stack(
        children: [
          TableCalendar(
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, focusedDay) {
                final text = day.day.toString();

                return Padding(
                  padding: const EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 4),
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    duration: Duration(microseconds: 2000),
                    child: Align(
                      alignment: Alignment(-0.25, -0.5),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              defaultBuilder: (context, day, focusedDay) {
                final text = day.day.toString();

                return Align(
                  alignment: Alignment(-0.25, -0.25),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: day.weekday == DateTime.saturday
                            ? Colors.blue
                            : day.weekday == DateTime.sunday
                                ? Colors.red
                                : null),
                  ),
                );
              },
              outsideBuilder: (context, day, focusedDay) {
                final text = day.day.toString();

                return Align(
                  alignment: Alignment(-0.25, -0.25),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.black45),
                  ),
                );
              },
              dowBuilder: (context, day) {
                final text = DateFormat.E().format(day);

                return Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: day.weekday == DateTime.saturday
                            ? Colors.blue
                            : day.weekday == DateTime.sunday
                                ? Colors.red
                                : null),
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                final text = day.day.toString();

                return Padding(
                  padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    duration: Duration(microseconds: 2000),
                    child: Align(
                      alignment: Alignment(-0.6, -0.75),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return _eventsMarker(events, day, _selectedDay);
                } else {
                  return null;
                }
              },
            ),
            focusedDay: _today,
            firstDay: DateTime.utc(_year - 2),
            lastDay: DateTime.utc(_year + 3),
            onDaySelected: (day, focusedDay) {
              setState(() {
                _selectedDay = day;
                _today = focusedDay;
                calenderService.addDetail(
                  _selectedDay,
                  widget.textTile,
                );
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
            eventLoader: calenderService.getEventsForDay,
          ),
          widget.textTile
              ? Positioned(
                  right: 8,
                  bottom: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.setDate!(_selectedDay);
                      Navigator.pop(context);
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
