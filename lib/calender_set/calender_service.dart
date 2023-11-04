import 'package:flutter/material.dart';

class Events {
  final String title;
  Events(this.title);
}

class CalenderService with ChangeNotifier {
  Map<DateTime, List<Events>> events = {};
  List<Events> selectedEventsInCalender = [];
  List<Events> selectedEventsInTile = [];
  late DateTime selectedCalenderDate;

  void addEvents(DateTime day, List<Events> title) {
    events.addAll({day: title});
    selectedEventsInCalender = getEventsForDay(selectedCalenderDate);
    notifyListeners();
  }

  void addDetail(DateTime selectedDay, bool textTile) {
    if (textTile) {
      selectedEventsInTile = getEventsForDay(selectedDay);
    } else {
      selectedCalenderDate = selectedDay;
      selectedEventsInCalender = getEventsForDay(selectedDay);
    }
    notifyListeners();
  }

  List<Events> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}
