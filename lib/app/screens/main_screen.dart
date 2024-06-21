import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/screens/create_card_screen.dart';
import 'package:wedding_app/app/screens/login_screen.dart';
import 'package:wedding_app/app/screens/tile_list_screen.dart';
import 'package:wedding_app/app/services/auth_service.dart';
import 'package:wedding_app/calender_set/calender_package.dart';

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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCardScreen()),
              );
            },
            icon: const Icon(Icons.add),
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
            child: Row(
              children: [
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: TileListScreen(),
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
    );
  }
}
