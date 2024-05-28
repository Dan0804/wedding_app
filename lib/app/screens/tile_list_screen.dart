import 'package:flutter/material.dart';
import 'package:wedding_app/app/services/card/fetch_tile_api.dart';

import '../models/tile.dart';
import '../widgets/tile_list.dart';

class TileListScreen extends StatefulWidget {
  const TileListScreen({super.key});

  @override
  State<TileListScreen> createState() => _TileListScreenState();
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
    backlogTiles = await getTileApi('BACKLOG');
    progressTiles = await getTileApi('PROGRESS');
    doneTiles = await getTileApi('DONE');
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Wedding To Do List',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Expanded(
                      child: TileList(
                        status: 'BACKLOG',
                        tiles: backlogTiles,
                      ),
                    ),
                    VerticalDivider(
                      width: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: TileList(
                        status: 'PROGRESS',
                        tiles: progressTiles,
                      ),
                    ),
                    VerticalDivider(
                      width: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: TileList(
                        status: 'DONE',
                        tiles: doneTiles,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
