import 'package:flutter/material.dart';
import 'package:roshambo/screens/game.dart';
import 'package:roshambo/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roshambo/screens/home.dart';
import 'package:roshambo/gameScrens/game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Roshambo());
}

class Roshambo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
