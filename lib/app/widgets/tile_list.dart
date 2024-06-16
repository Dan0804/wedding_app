import 'package:flutter/material.dart';
import '../models/tile.dart';

class TileList extends StatelessWidget {
  final String status;
  final List<Tile> tiles;
  final Function(Tile tile, String newStatus) onStatusChanged;

  const TileList({
    super.key,
    required this.status,
    required this.tiles,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tiles.length,
      itemBuilder: (context, index) {
        final tile = tiles[index];
        return ListTile(
          title: Text(tile.tileTitle),
          subtitle: Text('Budget: ${tile.budget}, Deadline: ${tile.deadline}'),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              // 상태 변경 로직을 호출합니다.
              String nextStatus = getNextStatus(tile.tileStatus);
              onStatusChanged(tile, nextStatus);
            },
          ),
        );
      },
    );
  }

  // 다음 상태를 결정하는 함수
  String getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case 'BACKLOG':
        return 'PROGRESS';
      case 'PROGRESS':
        return 'DONE';
      case 'DONE':
      default:
        return 'BACKLOG';
    }
  }
}
