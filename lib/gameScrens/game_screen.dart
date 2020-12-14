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
  int life_left = 2;
  var kActivecolor = Colors.lightGreenAccent;
  var kNotActiveColor = Colors.white24;

  @override
  Widget build(BuildContext context) {
    int LifeLeft() {
      setState(() {
        life_left = life_left - 1;
      });
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
          int currentUserScore = score;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GameOver(
                  currentUserScore: currentUserScore,
                );
              },
            ),
          );
          setState(() {
            life_left = 5;
            score = 0;
          });
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
                  borderRadius: BorderRadius.circular(20),
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
                    padding: EdgeInsets.all(13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            verdict.toUpperCase(),
                            style: kBottomSheetTextStyle.copyWith(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Container(
                          height: 250,
                          child: Image.asset('images/$computer_choice.png'),
                        ),
                        Text(
                          'OPPONENT - $computer_choice'.toUpperCase(),
                          style: kBottomSheetTextStyle,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                    ),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellowAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
