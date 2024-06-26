import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/models/tile.dart';
import 'package:wedding_app/app/services/tile_service.dart';

class DeleteTilePopUp extends StatefulWidget {
  final Tile tile;

  const DeleteTilePopUp({
    super.key,
    required this.tile,
  });

  @override
  State<DeleteTilePopUp> createState() => _DeleteTilePopUpState();
}

class _DeleteTilePopUpState extends State<DeleteTilePopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Card 삭제 Page'),
      ),
      content: SizedBox(
        height: 300,
        width: 400,
        child: Column(
          children: [
            Text(
              '아래 Card를 정말 삭제하시겠습니까?',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Card(
              elevation: 6,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tile.tileTitle,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text('Budget: ${NumberFormat('₩###,###,###,###').format(widget.tile.budget)}'),
                        widget.tile.deadline != DateTime(1994, 8, 4) ? Text('Deadline: ${DateFormat('yyyy-MM-dd').format(widget.tile.deadline)}') : Text('Deadline: 미정'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<TileService>(
                  builder: (context, tileService, child) {
                    return SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        child: const Text('삭제하기!'),
                        onPressed: () async {
                          bool isSuccess = await tileService.deleteTile(
                            widget.tile.tileId,
                          );
                          if (isSuccess) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Delete Created Successfully!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to Delete Card')),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '아니요!',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
