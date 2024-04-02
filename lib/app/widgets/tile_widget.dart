import 'package:flutter/material.dart';
import 'package:wedding_app/app/models/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget({required this.tile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
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
      ),
    );
  }
}
