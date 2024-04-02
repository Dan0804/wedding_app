import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/models/tile_model.dart';
import 'package:wedding_app/provider/tile_service.dart';
import 'package:wedding_app/widget/tile_tab/content_in_tile.dart';

class TileForm extends StatefulWidget {
  const TileForm({
    super.key,
    required this.tileData,
  });

  final Tiles tileData;

  @override
  State<TileForm> createState() => _TileFormState();
}

class _TileFormState extends State<TileForm> {
  bool forwardVisible = false;
  bool backVisible = false;

  Widget backwardArrowWidget(Tiles tileData) {
    if (tileData.state != 0) {
      return Consumer<TileService>(
        builder: (context, tileService, child) {
          return Positioned(
            left: 8,
            child: SizedBox(
              height: 40,
              width: 40,
              child: MouseRegion(
                onEnter: (event) {
                  setState(() {
                    backVisible = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    backVisible = false;
                  });
                },
                child: AnimatedOpacity(
                  opacity: backVisible == true ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: () {
                      tileService.changeStatus(tileData, "backward");
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget forwardArrowWidget(Tiles tileData) {
    if (tileData.state != 2) {
      return Consumer<TileService>(
        builder: (context, tileService, child) {
          return Positioned(
            right: 8,
            child: SizedBox(
              height: 40,
              width: 40,
              child: MouseRegion(
                onEnter: (event) {
                  setState(() {
                    forwardVisible = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    forwardVisible = false;
                  });
                },
                child: AnimatedOpacity(
                  opacity: forwardVisible == true ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: () {
                      tileService.changeStatus(tileData, "forward");
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              content: ContentInTile(
                tileData: widget.tileData,
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 5,
        color: Colors.black12,
        child: SizedBox(
          height: 64,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(widget.tileData.title),
              forwardArrowWidget(widget.tileData),
              backwardArrowWidget(widget.tileData),
            ],
          ),
        ),
      ),
    );
  }
}
