import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  GameCard(this.imageOf, this.onPress, this.color);

  String imageOf;
  Function onPress;
  Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
        padding: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Image.asset('images/$imageOf.png'),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: color,
        ),
      ),
    );
  }
}
