import 'package:flutter/material.dart';

class Events {
  final String title;
  Events(this.title);
}

class CalenderService with ChangeNotifier {
  Map<DateTime, List<Events>> events = {};
  List<Events> selectedEvents = [];

  void addEvents(DateTime day, List<Events> title) {
    events.addAll({day: title});
    notifyListeners();
  }

  void addDetailInTile(DateTime selectedDay) {
    selectedEvents = getEventsForDay(selectedDay);
    notifyListeners();
  }

  void addDetailInPackage(DateTime selectedDay) {
    selectedEvents = getEventsForDay(selectedDay);
    notifyListeners();
  }

  List<Events> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}
