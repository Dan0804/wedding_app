import 'package:flutter/material.dart';
import 'package:wedding_app/service_set/tile_service.dart';

class Events {
  final String title;
  Events(this.title);
}

final DateTime utcTime = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
Map<DateTime, List<Events>> events = {};

class CalenderService with ChangeNotifier {
  List<Events> selectedEventsInCalender = [];
  List<Events> selectedEventsInTile = [];
  DateTime selectedCalenderDate = utcTime;
  DateTime selectedTileDate = utcTime;

  void initDateInTile() {
    selectedEventsInTile = getEventsForDay(utcTime);
  }

  void collectEvents(List<Tiles> sortedList) {
    for (Tiles tile in sortedList) {
      if (events.containsKey(tile.arrangeDate)) {
        continue;
      } else if (tile.arrangeDate != DateTime.utc(1994, 8, 4) && events[tile.arrangeDate] != null) {
        events[tile.arrangeDate]!.add(Events(tile.title));
      } else if (tile.arrangeDate != DateTime.utc(1994, 8, 4)) {
        events[tile.arrangeDate] = [Events(tile.title)];
      }
    }

    notifyListeners();
  }

  // void addEvents(DateTime day, Events title) {
  //   DateTime editedDay = DateTime.utc(day.year, day.month, day.day);
  //   if (events[editedDay] != null) {
  //     events[editedDay]!.add(title);
  //   } else {
  //     events.addAll({
  //       editedDay: [title]
  //     });
  //   }
  //   initDateInTile();

  //   if (selectedCalenderDate == editedDay) {
  //     selectedEventsInCalender = getEventsForDay(editedDay);
  //   }
  //   notifyListeners();
  // }

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
