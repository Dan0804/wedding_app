import 'package:flutter/material.dart';

class Tiles {
  final Map<String, dynamic> tileDatas;

  Tiles(this.tileDatas);
}

class TileService with ChangeNotifier {
  List<Tiles> defaultTileData = [
    Tiles(
      {
        "title": "웨딩홀 잡기",
        "tile_id": "123456dnrerf",
        "status": "before",
        "arranged_date": DateTime.utc(1994, 8, 4),
        "checkboxs": {},
      },
    ),
    Tiles(
      {
        "title": "스튜디오 잡기",
        "tile_id": "asdfadsfasdf",
        "status": "before",
        "arranged_date": DateTime.utc(1994, 8, 4),
        "checkboxs": {},
      },
    ),
    Tiles(
      {
        "title": "신혼여행 잡기",
        "tile_id": "bvnmv1243q3",
        "status": "doing",
        "arranged_date": DateTime.utc(1994, 8, 4),
        "checkboxs": {},
      },
    ),
  ];

  List sortedList(String status) {
    List<Tiles> sortedList = [];

    for (Tiles tile in defaultTileData) {
      if (tile.tileDatas["status"] == status) {
        sortedList.add(tile);
      }
    }

    return sortedList;
  }

  void changeStatus(String status, Tiles tile) {
    var thisTile = defaultTileData.firstWhere((element) => element == tile);
    thisTile.tileDatas["status"] = "doing";

    notifyListeners();
  }
}
