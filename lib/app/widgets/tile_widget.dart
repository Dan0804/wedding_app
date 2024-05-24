import 'package:flutter/material.dart';
import 'package:wedding_app/app/models/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({
    super.key,
    required this.tile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tile.tileTitle,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Budget: ${tile.budget}'),
                Text('Deadline: ${tile.deadline.toString().split(' ')[0]}'),
              ],
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                String newStatus = getNextStatus(tile.tileStatus);
                // onStatusChanged(newStatus);
              },
            ),
          ],
        ),
      ),
    );
  }

  String getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case 'BACKLOG':
        return 'PROGRESS';
      case 'PROGRESS':
        return 'DONE';
      case 'DONE':
        return 'BACKLOG';
      default:
        return 'BACKLOG';
    }
  }
}
