import 'package:flutter/material.dart';
import 'package:wedding_app/tile_set/text_tile_detail.dart';

class EndTextTile extends StatefulWidget {
  const EndTextTile({super.key});

  @override
  State<EndTextTile> createState() => _EndTextTileState();
}

class _EndTextTileState extends State<EndTextTile> {
  bool backVisible = false;

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
              content: TextTileDetail(),
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
              Text("end"),
              Positioned(
                left: 8,
                child: SizedBox(
                  width: 40,
                  height: 40,
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
