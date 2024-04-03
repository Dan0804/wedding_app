import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/widget/calender_tab/calender_package.dart';
import 'package:wedding_app/provider/tile_service.dart';
import 'package:wedding_app/widget/tile_tab/tile_list_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TileService(),
        )
      ],
      child: const WeddingApp(),
    ),
  );
}

class WeddingApp extends StatelessWidget {
  const WeddingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        // Add this
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Center(
              child: Text(
                "Our Wedding Diary",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            actions: [
              Icon(
                Icons.person,
                color: Colors.black,
                size: 32,
              ),
              Icon(
                Icons.settings,
                color: Colors.black,
                size: 32,
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 64,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.3,
                    minHeight: 24,
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: TileListView(),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: CalenderPackage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
