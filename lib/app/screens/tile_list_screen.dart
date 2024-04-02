import 'package:flutter/material.dart';
import 'package:wedding_app/app/services/card/fetch_tile_api.dart';

import '../models/tile.dart';
import '../widgets/tile_list.dart';

class TileListScreen extends StatefulWidget {
  @override
  _TileListScreenState createState() => _TileListScreenState();
}

class _TileListScreenState extends State<TileListScreen> {
  List<Tile> backlogTiles = [];
  List<Tile> progressTiles = [];
  List<Tile> doneTiles = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    backlogTiles = await fetchTileApi('BACKLOG');
    progressTiles = await fetchTileApi('PROGRESS');
    doneTiles = await fetchTileApi('DONE');
    setState(() {});
  }
  
  void handleStatusChanged(Tile tile, String newStatus) {
    setState(() {
      switch (tile.tileStatus) {
        case 'BACKLOG':
          backlogTiles.remove(tile);
          break;
        case 'PROGRESS':
          progressTiles.remove(tile);
          break;
        case 'DONE':
          doneTiles.remove(tile);
          break;
      }

      switch (newStatus) {
        case 'BACKLOG':
          backlogTiles.add(tile);
          break;
        case 'PROGRESS':
          progressTiles.add(tile);
          break;
        case 'DONE':
          doneTiles.add(tile);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('웨딩 투두 리스트'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TileList(
              status: 'BACKLOG',
              tiles: backlogTiles,
              // onStatusChanged: (newStatus) {
              //   handleStatusChanged(tile, newStatus);
              // },
            ),
          ),
          Expanded(
            child: TileList(
              status: 'PROGRESS',
              tiles: progressTiles,
            ),
          ),
          Expanded(
            child: TileList(
              status: 'DONE',
              tiles: doneTiles,
            ),
          ),
        ],
      ),
    );
  }
}
