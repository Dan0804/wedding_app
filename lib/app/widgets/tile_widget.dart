import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/models/tile.dart';
import 'package:intl/intl.dart';
import 'package:wedding_app/app/services/card/fetch_tile_api.dart';
import 'package:wedding_app/app/widgets/edit_tile_pop_up.dart';

class TileWidget extends StatefulWidget {
  final Tile tile;

  const TileWidget({
    super.key,
    required this.tile,
  });

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  String addRest(budget) {
    int intBudget = budget.toInt();
    String budgetRest = NumberFormat('₩ ###,###,###,###').format(intBudget);
    return budgetRest;
  }

  bool _backVisible = false;
  bool _forwardVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return EditTilePopUp(
                tile: widget.tile,
              );
            });
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Consumer<FetchTileApi>(builder: (context, fetchTileApi, child) {
            return Flex(
              direction: Axis.horizontal,
              children: [
                widget.tile.tileStatus != "BACKLOG"
                    ? MouseRegion(
                        onEnter: (PointerEvent details) {
                          setState(() {
                            _backVisible = true;
                          });
                        },
                        onExit: (PointerEvent details) {
                          setState(() {
                            _backVisible = false;
                          });
                        },
                        child: AnimatedOpacity(
                          opacity: _backVisible ? 1 : 0,
                          duration: Duration(milliseconds: 300),
                          child: IconButton(
                            onPressed: () {
                              if (widget.tile.tileStatus == "PROGRESS") {
                                Map<String, dynamic> editData = {"cardStatus": "BACKLOG"};
                                fetchTileApi.editTile(widget.tile.tileId, editData);
                              } else if (widget.tile.tileStatus == "DONE") {
                                Map<String, dynamic> editData = {"cardStatus": "PROGRESS"};
                                fetchTileApi.editTile(widget.tile.tileId, editData);
                              }
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      )
                    : Container(),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
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
                      Text('Budget: ${addRest(widget.tile.budget)}'),
                      widget.tile.deadline != DateTime(1994, 8, 4) ? Text('Deadline: ${DateFormat('yyyy-MM-dd').format(widget.tile.deadline)}') : Text('Deadline: 미정'),
                    ],
                  ),
                ),
                widget.tile.tileStatus != "DONE"
                    ? MouseRegion(
                        onEnter: (PointerEvent details) {
                          setState(() {
                            _forwardVisible = true;
                          });
                        },
                        onExit: (PointerEvent details) {
                          setState(() {
                            _forwardVisible = false;
                          });
                        },
                        child: AnimatedOpacity(
                          opacity: _forwardVisible ? 1 : 0,
                          duration: Duration(milliseconds: 300),
                          child: IconButton(
                            onPressed: () {
                              if (widget.tile.tileStatus == "BACKLOG") {
                                Map<String, dynamic> editData = {"cardStatus": "PROGRESS"};
                                fetchTileApi.editTile(widget.tile.tileId, editData);
                              } else if (widget.tile.tileStatus == "PROGRESS") {
                                Map<String, dynamic> editData = {"cardStatus": "DONE"};
                                fetchTileApi.editTile(widget.tile.tileId, editData);
                              }
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                      )
                    : Container()
                // IconButton(
                //   icon: Icon(Icons.delete),
                //   color: Colors.redAccent,
                //   onPressed: () {
                //     showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return DeleteTilePopUp(
                //             tile: tile,
                //           );
                //         });
                //   },
                // ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
