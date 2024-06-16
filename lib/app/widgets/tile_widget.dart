import 'package:flutter/material.dart';
import 'package:wedding_app/app/models/tile.dart';
import 'package:intl/intl.dart';
import 'package:wedding_app/app/widgets/delete_tile_pop_up.dart';
import 'package:wedding_app/app/widgets/edit_tile_pop_up.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({
    super.key,
    required this.tile,
  });

  String addRest(budget) {
    int intBudget = budget.toInt();
    String budgetRest = NumberFormat('₩ ###,###,###,###').format(intBudget);
    return budgetRest;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditTilePopUp(
                tile: tile,
              );
            });
      },
      child: Card(
        elevation: 10,
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
                  Text('Budget: ${addRest(tile.budget)}'),
                  tile.deadline != DateTime(1994, 8, 4) ? Text('Deadline: ${DateFormat('yyyy-MM-dd').format(tile.deadline)}') : Text('Deadline: 미정'),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      print('change status');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.redAccent,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteTilePopUp(
                              tile: tile,
                            );
                          });
                    },
                  ),
                ],
              ),
            ],
          ),
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
