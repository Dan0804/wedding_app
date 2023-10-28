import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
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

class Events {
  final String title;
  Events(this.title);
}

class _CalenderState extends State<Calender> {
  final int _year = DateTime.now().year;
  DateTime _today = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Events>> events = {};
  late final ValueNotifier<List<Events>> _selectEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _today;
    _selectEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Events> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
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
      focusedDay: _today,
      firstDay: DateTime.utc(_year - 2),
      lastDay: DateTime.utc(_year + 3),
      onDaySelected: (day, focusedDay) {
        setState(() {
          _today = day;
          events.addAll({
            _selectedDay!: [Events("test")]
          });
          _selectEvents.value = _getEventsForDay(_selectedDay!);
          print("tap");
        });
      },
      selectedDayPredicate: (day) {
        return isSameDay(day, _today);
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
      eventLoader: _getEventsForDay,
    );
  }
}
