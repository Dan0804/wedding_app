import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/screens/login_screen.dart';
import 'package:wedding_app/app/screens/tile_list_screen.dart';
import 'package:wedding_app/app/services/auth_service.dart';
import 'package:wedding_app/app/services/tile_service.dart';
import 'package:wedding_app/app/widgets/forCalender/calender_package.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Center(
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
          Consumer<AuthService>(builder: (context, authService, child) {
            return IconButton(
              onPressed: () {
                authService.logOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.login),
            );
          }),
          const Icon(
            Icons.person,
            color: Colors.black,
            size: 32,
          ),
          const Icon(
            Icons.settings,
            color: Colors.black,
            size: 32,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
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
            flex: 1,
            fit: FlexFit.tight,
            child: Consumer<TileService>(builder: (context, tileService, child) {
              return FutureBuilder(
                  future: tileService.fetchAllTiles(),
                  builder: (context, snapshot) {
                    var datas = snapshot.data ?? [];
                    if (datas.isNotEmpty) {
                      tileService.calendarTiles = {};
                      tileService.calendarDatas(datas[0]);
                      tileService.calendarDatas(datas[1]);
                      tileService.calendarDatas(datas[2]);
                    }

                    return datas.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            children: [
                              Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: TileListScreen(
                                  tileDatas: datas,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: CalenderPackage(),
                              ),
                            ],
                          );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
