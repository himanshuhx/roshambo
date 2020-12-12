import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'register.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showSpinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        color: Colors.redAccent,
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
                  text: ['Welcome Back', 'We Miss You', 'Login And Play'],
                  textStyle: kHeadingTextStyle,
                  textAlign: TextAlign.center,
                  colors: [
                    Color(0xffFB5757),
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
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
                onPressed: () async {
                  final user = await _auth.signInWithEmailAndPassword(
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
                    'New User ??  Register',
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
                            return Register();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'here',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
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
