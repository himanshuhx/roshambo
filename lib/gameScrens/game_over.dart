import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/score_card.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class GameOver extends StatefulWidget {
  final int currentUserScore;
  const GameOver({Key key, this.currentUserScore}) : super(key: key);

  @override
  _GameOverState createState() =>
      _GameOverState(currentUserScore: this.currentUserScore);
}

class _GameOverState extends State<GameOver> {
  int currentUserScore;
  int currentUserHighScore;
  String firstRankerName;
  int firstRankerScore;
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
    setState(() {
      showSpinner = false;
    });
  }

  void getCurrentUserHighScore() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        _firestore
            .collection("users")
            .doc(loggedInUser.uid)
            .get()
            .then((value) {
          currentUserHighScore = value.data()['score'] ?? currentUserScore;
          if (currentUserScore >= currentUserHighScore) {
            _firestore
                .collection('users')
                .doc(loggedInUser.uid)
                .update({'score': currentUserScore});
          }
          print(currentUserHighScore);
          setState(() {
            showSpinner = false;
            currentUserScore;
          });
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
          firstRankerName = user['nickName'] ?? 'anonymous';
          firstRankerScore = user['score'];
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      color: Color(0xff1B192D),
      opacity: 0.75,
      progressIndicator: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 30,
        child: LiquidLinearProgressIndicator(
          value: 0.25,
          valueColor: AlwaysStoppedAnimation(Colors.green),
          backgroundColor: Colors.black45,
          direction: Axis.horizontal,
        ),
      ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScoreCard(),
                    ScoreCard(),
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
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.autorenew,
                          size: 35,
                          color: Colors.black45,
                        ),
                        radius: 35,
                        backgroundColor: Colors.lightGreenAccent,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ < 2);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.home,
                          size: 35,
                          color: Colors.black45,
                        ),
                        radius: 35,
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                    ),
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
