import 'package:flutter/material.dart';

class Events {
  final String title;
  Events(this.title);
}

final DateTime utcTime = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

class CalenderService with ChangeNotifier {
  Map<DateTime, List<Events>> events = {};
  List<Events> selectedEventsInCalender = [];
  List<Events> selectedEventsInTile = [];
  DateTime selectedCalenderDate = utcTime;
  DateTime selectedTileDate = utcTime;

  void initDateInTile() {
    selectedEventsInTile = getEventsForDay(utcTime);
  }

  void addEvents(DateTime day, Events title) {
    DateTime editedDay = DateTime.utc(day.year, day.month, day.day);
    if (events[editedDay] != null) {
      events[editedDay]!.add(title);
    } else {
      events.addAll({
        editedDay: [title]
      });
    }
    initDateInTile();

    if (selectedCalenderDate == editedDay) {
      selectedEventsInCalender = getEventsForDay(editedDay);
    }
    notifyListeners();
  }

  void addDetail(DateTime selectedDay, bool textTile) {
    if (textTile) {
      selectedEventsInTile = getEventsForDay(selectedDay);
      selectedTileDate = selectedDay;
    } else {
      selectedEventsInCalender = getEventsForDay(selectedDay);
      selectedCalenderDate = selectedDay;
    }
    notifyListeners();
  }

  List<Events> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}
