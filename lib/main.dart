import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/services/auth_service.dart';
import 'package:wedding_app/service_set/tile_service.dart';

import 'app/screens/login_screen.dart';
import 'app/screens/main_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TileService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
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
      home: Consumer<AuthService>(
        builder: (context, authService, child) {
          authService.checkLoginStatus();
          if (authService.isLoggedIn) {
            return MainScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
