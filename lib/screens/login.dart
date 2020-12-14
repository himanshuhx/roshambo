import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/button.dart';
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
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.amberAccent,
        opacity: 0.50,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.greenAccent,
                child: Image.asset('images/icon.png'),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldStyle.copyWith(
                    hintText: 'Email Id Here',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                style: TextStyle(
                  color: Colors.white70,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldStyle.copyWith(
                    hintText: 'Password Here',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                title: 'Login',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);

                  try {
                    if (user != null) {
                      // setState(() {
                      //   showSpinner = false;
                      // });
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
                      color: Colors.white70,
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
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Pacifico',
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
