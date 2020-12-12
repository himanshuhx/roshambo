import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'login.dart';
import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showSpinner = false;
  String email;
  String password;
  String nickName;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Hero(
                  tag: 'tag',
                  child: Container(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.redAccent,
                      child: Image.asset('images/icon.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ColorizeAnimatedTextKit(
                  isRepeatingAnimation: true,
                  text: ['Hey Sign up', 'To play', 'Roshambo'],
                  textStyle: kHeadingTextStyle,
                  textAlign: TextAlign.center,
                  colors: [
                    Color(0xffFB5757),
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldStyle.copyWith(
                    hintText: 'Enter your mail',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldStyle.copyWith(
                    hintText: 'Password Here',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                title: 'Login',
                color: Colors.lightGreen,
                onPressed: () async {
                  final user = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Home();
                          },
                        ),
                      );
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } catch (e) {}
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?? SignIn',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'here',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
