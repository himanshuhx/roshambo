import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String nickName = 'unknown';
  bool showSpinner = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        _firestore
            .collection("users")
            .doc(loggedInUser.uid)
            .get()
            .then((value) {
          nickName = value.data()['nickName'] ?? 'unknown';
          setState(() {
            showSpinner = false;
            nickName;
          });
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff1E1E20),
      body: ModalProgressHUD(
        color: Colors.black54,
        opacity: 0.85,
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      // onTap: getImage from gallery,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.black45,
                        child: Image.asset('images/profilePic.png'),
                      ),
                    ),
                    Text(
                      nickName.toUpperCase(),
                      style: kNickNameStyle,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.length > 6) {
                          return 'Max 1-6 characters allowed';
                        } else if (value.isEmpty) {
                          return 'please enter some text';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        nickName = value;
                      },
                      decoration: kTextFieldStyle.copyWith(
                          hintText: 'Enter your new Name',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          )),
                    ),
                    Button(
                      title: 'Update',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          _firestore
                              .collection('users')
                              .doc(loggedInUser.uid)
                              .update({
                            'nickName': nickName,
                          });
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
