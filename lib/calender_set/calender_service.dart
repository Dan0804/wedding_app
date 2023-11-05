import 'package:flutter/material.dart';

class Events {
  final String title;
  Events(this.title);
}

class CalenderService with ChangeNotifier {
  Map<DateTime, List<Events>> events = {};
  List<Events> selectedEventsInCalender = [];
  List<Events> selectedEventsInTile = [];
  DateTime selectedCalenderDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime selectedTileDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final DateTime initDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  void initDateInTile() {
    selectedEventsInTile = getEventsForDay(initDate);
  }

  void addEvents(DateTime day, List<Events> title) {
    DateTime editedDay = DateTime.utc(day.year, day.month, day.day);
    events.addAll({editedDay: title});
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
