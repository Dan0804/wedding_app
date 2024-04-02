import 'package:flutter/material.dart';
import 'package:wedding_app/models/tile_model.dart';
import 'package:wedding_app/models/calender_model.dart';

class TileService with ChangeNotifier {
  // tile data area
  List<Tiles> tileData = [
    Tiles(
      "웨딩홀 잡기",
      "123456dnrerf",
      "123123asdasd",
      0,
      DateTime.utc(2023, 12, 20),
      [],
    ),
    Tiles(
      "스튜디오 잡기",
      "asdfadsfasdf",
      "123123asdasd",
      0,
      DateTime.utc(1994, 8, 4),
      [],
    ),
    Tiles(
      "신혼여행 잡기",
      "bvnmv1243q3",
      "123123asdasd",
      1,
      DateTime.utc(1994, 8, 4),
      [],
    ),
  ];

  DateTime selectedInit = utcTime;

  List<Tiles> sortedList(int status) {
    List<Tiles> sortedList = [];

    for (Tiles tile in tileData) {
      if (tile.state == status) {
        sortedList.add(tile);
      }
    }

    return sortedList;
  }

  void collectEvents() {
    Map<DateTime, List<Events>> tempEvents = {};
    for (Tiles tile in tileData) {
      if (tempEvents[tile.arrangeDate] != null) {
        tempEvents[tile.arrangeDate]!.add(Events(tile.title));
      } else {
        tempEvents[tile.arrangeDate] = [Events(tile.title)];
      }
    }

    events = tempEvents;
  }

  void changeStatus(Tiles tile, String arrow) {
    var thisTile = tileData.firstWhere((element) => element == tile);

    if (arrow == "forward") {
      thisTile.state += 1;
    } else {
      thisTile.state -= 1;
    }

    notifyListeners();
  }

  void changeContents(String tileId, String title, DateTime arrangeDate, List<CheckBoxs> checkBox) {
    var thisTile = tileData.firstWhere((element) => element.tileId == tileId);

    thisTile.title = title;
    thisTile.arrangeDate = arrangeDate;
    thisTile.checkBoxs = checkBox;

    notifyListeners();
  }

  // calender data area

  // divided data in calender_set and text_tile_detail
  List<Events> selectedEventsInCalender = [];
  List<Events> selectedEventsInTile = [];

  void addDetail(bool textTile) {
    if (textTile) {
      selectedEventsInTile = getEventsForDay(selectedInit);
    } else {
      selectedEventsInCalender = getEventsForDay(selectedInit);
    }
  }

  List<Events> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}
