import 'package:flutter/material.dart';
import 'package:roshambo/screens/game.dart';
import 'package:roshambo/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roshambo/screens/home.dart';
import 'package:roshambo/gameScrens/game_screen.dart';
import 'package:roshambo/components/score_card.dart';
import 'package:roshambo/gameScrens/game_over.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Roshambo());
}

class Roshambo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Color(0xff1B192D),
      ),
      home: Login(),
    );
  }
}
