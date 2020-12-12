import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  GameOver({this.currentUserScore});

  final currentUserScore;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('GAME OVER'),
      ),
    );
  }
}
