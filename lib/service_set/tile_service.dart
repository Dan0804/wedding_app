import 'package:flutter/material.dart';

class CheckBoxs {
  bool isChecked;
  String text;

  CheckBoxs(this.isChecked, this.text);
}

class Tiles {
  String title;
  final String tileId;
  int state;
  DateTime arrangeDate;
  List<CheckBoxs> checkBoxs;

  Tiles(this.title, this.tileId, this.state, this.arrangeDate, this.checkBoxs);

  /* Tile 구성
      title(String) : tile의 title
      tile_id(String) : 난수로 형성?
      status(int) : 0(before), 1(doing), 2(done)으로 구분하기
      arrange_data(DateTime) : 1994.8.4는 날짜를 선택하지 않았을 시 default값, 선택하면 그 날로 입력
      checkboxs(List<Map<String, dynamic>>) : Map에는 checkbox status와 text만 넣기

       --------- checkbox example ----------
      | {                                   |
      |   "checkbox" : false,               |
      |   "text" : "text contents"          |
      | },                                  |
      | {                                   |
      |   "checkbox" : false,               |
      |   "text" : "another text contents"  |
      | }                                   |
       -------------------------------------
  */
}

class TileService with ChangeNotifier {
  List<Tiles> defaultTileData = [
    Tiles(
      "웨딩홀 잡기",
      "123456dnrerf",
      0,
      DateTime.utc(1994, 8, 4),
      [],
    ),
    Tiles(
      "스튜디오 잡기",
      "asdfadsfasdf",
      0,
      DateTime.utc(1994, 8, 4),
      [],
    ),
    Tiles(
      "신혼여행 잡기",
      "bvnmv1243q3",
      1,
      DateTime.utc(1994, 8, 4),
      [],
    ),
  ];

  List sortedList(int status) {
    List<Tiles> sortedList = [];

    for (Tiles tile in defaultTileData) {
      if (tile.state == status) {
        sortedList.add(tile);
      }
    }

    return sortedList;
  }

  void changeStatus(Tiles tile, String arrow) {
    var thisTile = defaultTileData.firstWhere((element) => element == tile);

    if (arrow == "forward") {
      thisTile.state += 1;
    } else {
      thisTile.state -= 1;
    }

    notifyListeners();
  }

  void changeContents(String tileId, String title, DateTime arrangeDate, List<CheckBoxs> checkBox) {
    var thisTile = defaultTileData.firstWhere((element) => element.tileId == tileId);

    thisTile.title = title;
    thisTile.arrangeDate = arrangeDate;
    thisTile.checkBoxs = checkBox;

    notifyListeners();
  }
}
