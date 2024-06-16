import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/services/card/fetch_tile_api.dart';
import '../widgets/tile_list.dart';

class TileListScreen extends StatefulWidget {
  const TileListScreen({super.key});

  @override
  State<TileListScreen> createState() => _TileListScreenState();
}

class _TileListScreenState extends State<TileListScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<FetchTileApi>().fetchAllTiles();
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
              Consumer<FetchTileApi>(builder: (context, fetchTileApi, child) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Expanded(
                        child: TileList(
                          status: 'BACKLOG',
                          tiles: fetchTileApi.backlogTiles,
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: TileList(
                          status: 'PROGRESS',
                          tiles: fetchTileApi.progressTiles,
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: TileList(
                          status: 'DONE',
                          tiles: fetchTileApi.doneTiles,
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
