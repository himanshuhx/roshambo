import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/gameScrens/game_screen.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return GameScreen();
            },
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Color(0xff1B192D),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.2,
            //   child: FadeAnimatedTextKit(
            //     repeatForever: true,
            //     text: ["Tap To Play"],
            //     textStyle: TextStyle(
            //       fontSize: 40,
            //       fontWeight: FontWeight.w900,
            //       color: Colors.green,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            Padding(
                padding: EdgeInsets.all(25),
                child: Image.asset('images/game_start_icon.png')),
          ],
        ),
      ),
    );
  }
}
