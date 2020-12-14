import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ScoreCard extends StatelessWidget {
  ScoreCard({this.text, this.userName, this.score});

  final String text;
  final String userName;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16, left: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 35, bottom: 10, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      text.toUpperCase(),
                      style: kGameCardStyle,
                    ),
                  ),
                  Text(
                    userName.toUpperCase(),
                    style: kGameCardStyle,
                  ),
                  Text(
                    score.toString(),
                    style: kGameCardStyle,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff1E1E20),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 230),
            child: CircleAvatar(
              radius: 50,
              //foregroundColor: Color(0xff1B192D),
              backgroundColor: Color(0xffFD673B),
              child: Image.asset('images/icon.png'),
            ),
          ),
        ],
      ),
    );
  }
}
