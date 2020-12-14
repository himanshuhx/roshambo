import 'package:flutter/material.dart';
import 'package:roshambo/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

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
        scaffoldBackgroundColor: Color(0xff1E1E20),
      ),
      home: Login(),
    );
  }
}
