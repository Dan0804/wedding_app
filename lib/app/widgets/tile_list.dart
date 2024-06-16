import 'package:flutter/material.dart';
import 'package:wedding_app/app/models/tile.dart';

import 'tile_widget.dart';

class TileList extends StatelessWidget {
  final String status;
  final List<Tile> tiles;

  const TileList({
    super.key,
    required this.status,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tiles.length,
            itemBuilder: (context, index) {
              return TileWidget(
                tile: tiles[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
