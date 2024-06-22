import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/screens/create_card_screen.dart';
import 'package:wedding_app/app/services/card/fetch_tile_api.dart';
import '../widgets/tile_list.dart';

class TileListScreen extends StatefulWidget {
  const TileListScreen({super.key});

  @override
  State<TileListScreen> createState() => _TileListScreenState();
}

class _TileListScreenState extends State<TileListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FetchTileApi>(builder: (context, fetchTileApi, child) {
      return FutureBuilder(
          future: fetchTileApi.fetchAllTiles(),
          builder: (context, snapshot) {
            var datas = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Wedding To Do List',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          datas.isEmpty
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Flexible(
                                  fit: FlexFit.tight,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TileList(
                                          status: 'BACKLOG',
                                          tiles: datas[0],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: TileList(
                                          status: 'PROGRESS',
                                          tiles: datas[1],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: TileList(
                                          status: 'DONE',
                                          tiles: datas[2],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateCardScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                          ),
                          Text(
                            'New Card 생성',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
