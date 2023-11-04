import 'package:flutter/material.dart';
import 'package:wedding_app/tile_set/text_tile_detail.dart';

class BeforeTextTile extends StatefulWidget {
  const BeforeTextTile({super.key});

  @override
  State<BeforeTextTile> createState() => _BeforeTextTileState();
}

class _BeforeTextTileState extends State<BeforeTextTile> {
  bool forwardVisible = false;

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
              Text("before"),
              Positioned(
                right: 8,
                child: SizedBox(
                  width: 40,
                  height: 40,
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
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
