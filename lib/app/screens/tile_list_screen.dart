import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/services/card/fetch_tile_api.dart';
import '../models/tile.dart';
import '../widgets/tile_list.dart';

class TileListScreen extends StatefulWidget {
  const TileListScreen({super.key});

  @override
  State<TileListScreen> createState() => _TileListScreenState();
}

class _TileListScreenState extends State<TileListScreen> {
  @override
  void initState() {
    super.initState();
    // 초기화 시 모든 타일을 가져옵니다.
    Future.microtask(() => Provider.of<FetchTileApi>(context, listen: false).fetchAllTiles());
  }

  void handleStatusChanged(Tile tile, String newStatus) {
    // FetchTileApi의 updateTileStatus 호출
    Provider.of<FetchTileApi>(context, listen: false).updateTileStatus(tile, newStatus);
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
              const Text(
                'Wedding To Do List',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Consumer<FetchTileApi>(builder: (context, fetchTileApi, child) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Expanded(
                        child: TileList(
                          status: 'BACKLOG',
                          tiles: fetchTileApi.backlogTiles,
                          onStatusChanged: handleStatusChanged,
                        ),
                      ),
                      const VerticalDivider(width: 1, color: Colors.grey),
                      Expanded(
                        child: TileList(
                          status: 'PROGRESS',
                          tiles: fetchTileApi.progressTiles,
                          onStatusChanged: handleStatusChanged,
                        ),
                      ),
                      const VerticalDivider(width: 1, color: Colors.grey),
                      Expanded(
                        child: TileList(
                          status: 'DONE',
                          tiles: fetchTileApi.doneTiles,
                          onStatusChanged: handleStatusChanged,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
