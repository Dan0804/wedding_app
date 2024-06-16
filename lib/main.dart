import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wedding_app/app/services/auth_service.dart';
import 'package:wedding_app/service_set/tile_service.dart';
import 'app/screens/login_screen.dart';
import 'app/screens/main_screen.dart';

void main() async {
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
    context.read<AuthService>().checkLoginStatus();
    return Consumer<AuthService>(builder: (context, authService, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('ko'),
          ],
          home: authService.isLoggedIn ? MainScreen() : LoginScreen());
    });
  }
}
