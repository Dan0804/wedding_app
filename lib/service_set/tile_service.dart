import 'package:flutter/material.dart';

class Tiles {
  final Map<String, dynamic> tileDatas;

  Tiles(this.tileDatas);

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
      {
        "title": "웨딩홀 잡기",
        "tile_id": "123456dnrerf",
        "status": 0,
        "arranged_date": DateTime.utc(1994, 8, 4),
        "checkboxs": [],
      },
    ),
    Tiles(
      {
        "title": "스튜디오 잡기",
        "tile_id": "asdfadsfasdf",
        "status": 0,
        "arranged_date": DateTime.utc(1994, 8, 4),
        "checkboxs": [],
      },
    ),
    Tiles(
      {
        "title": "신혼여행 잡기",
        "tile_id": "bvnmv1243q3",
        "status": 1,
        "arranged_date": DateTime.utc(1994, 8, 4),
        "checkboxs": [],
      },
    ),
  ];

  List sortedList(int status) {
    List<Tiles> sortedList = [];

    for (Tiles tile in defaultTileData) {
      if (tile.tileDatas["status"] == status) {
        sortedList.add(tile);
      }
    }

    return sortedList;
  }

  void changeStatus(Tiles tile, String arrow) {
    var thisTile = defaultTileData.firstWhere((element) => element == tile);

    if (arrow == "forward") {
      thisTile.tileDatas["status"] += 1;
    } else {
      thisTile.tileDatas["status"] -= 1;
    }

    notifyListeners();
  }
}
