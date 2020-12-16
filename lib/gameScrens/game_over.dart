import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/score_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'game_screen.dart';
import 'package:roshambo/screens/about.dart';

class GameOver extends StatefulWidget {
  final int currentUserScore;
  const GameOver({Key key, this.currentUserScore}) : super(key: key);

  @override
  _GameOverState createState() =>
      _GameOverState(currentUserScore: this.currentUserScore);
}

class _GameOverState extends State<GameOver> {
  int currentUserScore;
  int currentUserHighScore = 0;
  String currentUserName = 'unknown';
  String firstRankerName = 'unknown';
  int firstRankerScore = 0;
  bool showSpinner = true;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;

  _GameOverState({this.currentUserScore});

  @override
  void initState() {
    super.initState();
    getCurrentUserHighScore();
    getUserWithHighScore();
  }

  void getCurrentUserHighScore() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        try {
          _firestore
              .collection("users")
              .doc(loggedInUser.uid)
              .get()
              .then((value) {
            currentUserHighScore = value.data()['score'];
            currentUserName = value.data()['nickName'];
            print(currentUserName);
            print(currentUserHighScore);

            if (currentUserScore >= currentUserHighScore) {
              currentUserHighScore = currentUserScore;
              _firestore.collection('users').doc(loggedInUser.uid).update({
                'score': currentUserScore,
              });
            }
          });
        } catch (e) {}
        setState(() {
          currentUserScore;
        });
      }
    } catch (e) {}
  }

  void getUserWithHighScore() {
    Query query = _firestore
        .collection('users')
        .orderBy('score', descending: true)
        .limit(1);
    query.get().then((value) => value.docs.forEach((user) {
          setState(() {
            firstRankerName = user['nickName'] ?? 'unknown';
            firstRankerScore = user['score'] ?? 0;
          });
        }));
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      color: Colors.black54,
      opacity: 0.80,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'GAME OVER',
                  style: kGameOverTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScoreCard(
                      text: 'Rank 1',
                      userName: firstRankerName,
                      score: firstRankerScore,
                    ),
                    ScoreCard(
                      text: 'HIGHSCORE',
                      userName: currentUserName,
                      score: currentUserHighScore,
                    ),
                  ],
                ),
                Text(
                  'YOUR SCORE  $currentUserScore',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Russo One',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        for (int i = 0; i < 3; i++) {
                          Navigator.pop(context);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return GameScreen();
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.autorenew,
                          size: 35,
                          color: Colors.black45,
                        ),
                        radius: 35,
                        backgroundColor: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        for (int i = 0; i < 3; i++) {
                          Navigator.pop(context);
                        }
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.home,
                          size: 35,
                          color: Colors.black45,
                        ),
                        radius: 35,
                        backgroundColor: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return About();
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.info_sharp,
                          size: 35,
                          color: Colors.black45,
                        ),
                        radius: 35,
                        backgroundColor: Colors.blue,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
