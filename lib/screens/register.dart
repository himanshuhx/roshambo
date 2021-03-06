import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  final _formKey = GlobalKey<FormState>();

  void createUserFieldsInFirestore() async {
    _firestore.collection('users').doc(loggedInUser.uid).set({
      'nickName': 'unknown',
      'score': 0,
      'userUid': loggedInUser.uid,
    }).then((value) => setState(() {
          showSpinner = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: Colors.black54,
        opacity: 0.85,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white24,
                  child: Image.asset('images/icon.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  validator: (value) {
                    if (!value.endsWith('.com')) {
                      return 'Email should be of type example@email.com';
                    }
                    return null;
                  },
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
                TextFormField(
                  validator: (value) {
                    if (value.length < 6) {
                      return 'password should be at least 6 characters long';
                    }
                    return null;
                  },
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
                  title: 'SignUp',
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      try {
                        if (user != null) {
                          loggedInUser = _auth.currentUser;
                          createUserFieldsInFirestore();
                        }
                      } catch (e) {
                        print('problem occured in signup try');
                      }
                    }
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
                              return Login();
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
      ),
    );
  }
}
