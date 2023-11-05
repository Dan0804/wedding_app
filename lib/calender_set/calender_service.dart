import 'package:flutter/material.dart';

class Events {
  final String title;
  Events(this.title);
}

class CalenderService with ChangeNotifier {
  Map<DateTime, List<Events>> events = {};
  List<Events> selectedEventsInCalender = [];
  List<Events> selectedEventsInTile = [];
  DateTime? selectedCalenderDate;
  final initDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  void initDateInTile() {
    selectedEventsInTile = getEventsForDay(initDate);
  }

  void addEvents(DateTime day, List<Events> title) {
    if (selectedCalenderDate == null) {
      events.addAll({initDate: title});
      selectedEventsInCalender = getEventsForDay(initDate);
      initDateInTile();
    } else {
      events.addAll({day: title});
      selectedEventsInCalender = getEventsForDay(selectedCalenderDate!);
    }
    notifyListeners();
  }

  void addDetail(DateTime selectedDay, bool textTile) {
    if (textTile) {
      selectedEventsInTile = getEventsForDay(selectedDay);
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
