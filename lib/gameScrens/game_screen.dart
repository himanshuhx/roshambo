import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/game_card.dart';
import 'game_over.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int computer_choice_no = 3;
  String computer_choice = 'rock';
  String user_choice = 'paper';
  String verdict;
  int score = 0;
  int life_left = 5;
  var kActivecolor = Colors.lightGreenAccent;
  var kNotActiveColor = Colors.white38;

  @override
  Widget build(BuildContext context) {
    int LifeLeft() {
      life_left = life_left - 1;
      return life_left;
    }

    void Score(String user_choice, String computer_choice, int life_left) {
      if ((user_choice == 'paper' && computer_choice == 'rock') ||
          (user_choice == 'rock' && computer_choice == 'scissors') ||
          (user_choice == 'scissors' && computer_choice == 'paper')) {
        setState(() {
          score += 100;
          verdict = 'YAY you Win! 😍';
        });
      } else if (user_choice == computer_choice) {
        setState(() {
          verdict = 'Tie 😵';
        });
      } else {
        setState(() {
          verdict = 'You Loose 🥺';
        });
        life_left = LifeLeft();
        if (life_left == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GameOver(
                  currentUserScore: score,
                );
              },
            ),
          );
        } else {
          setState(() {
            life_left;
          });
        }
      }
    }

    String computerChoice() {
      computer_choice_no = Random().nextInt(3) + 1;
      if (computer_choice_no == 1) {
        return 'rock';
      } else if (computer_choice_no == 2) {
        return 'paper';
      } else {
        return 'scissors';
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff1B192D),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'SCORE',
                      style: kGameHeadingStyle,
                    ),
                    Text(
                      score.toString(),
                      style: kGameHeadingStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'LIFE',
                      style: kGameHeadingStyle,
                    ),
                    Text(
                      '$life_left/5',
                      style: kGameHeadingStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GameCard('rock', () {
                        setState(() {
                          user_choice = 'rock';
                        });
                      },
                          user_choice == 'rock'
                              ? kActivecolor
                              : kNotActiveColor),
                      GameCard('paper', () {
                        setState(() {
                          user_choice = 'paper';
                        });
                      },
                          user_choice == 'paper'
                              ? kActivecolor
                              : kNotActiveColor),
                      GameCard('scissors', () {
                        setState(() {
                          user_choice = 'scissors';
                        });
                      },
                          user_choice == 'scissors'
                              ? kActivecolor
                              : kNotActiveColor),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1,
                      padding: EdgeInsets.all(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              verdict,
                              style: kBottomSheetTextStyle,
                            ),
                          ),
                          Container(
                            height: 200,
                            padding: EdgeInsets.all(30),
                            child: Image.asset('images/$computer_choice.png'),
                          ),
                          Text(
                            'Your Opponent Chose',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xff2D2D2D)),
                  ),
                );
                setState(() {
                  computer_choice = computerChoice();
                });
                Score(user_choice, computer_choice, life_left);
              },
              child: Container(
                child: Text(
                  'Throw',
                  style: kGameButtonTextStyle,
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                color: Color(0xff6539B3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
