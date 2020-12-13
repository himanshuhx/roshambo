import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:roshambo/components/constants.dart';
import 'package:roshambo/components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String nickName = 'anonymous';
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    setState(() {
      showSpinner = true;
    });
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
          nickName = value.data()['nickName'] ?? 'anonymous';
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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff1B192D),
      body: ModalProgressHUD(
        color: Color(0xff1B192D),
        inAsyncCall: showSpinner,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 30),
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                // onTap: ,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.amber,
                  child: Image.asset('images/icon.png'),
                ),
              ),
              Text(
                nickName.toUpperCase(),
                style: kNickNameStyle,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                ),
                onChanged: (value) {
                  nickName = value;
                },
                decoration: kTextFieldStyle.copyWith(
                    hintText: 'Enter your new Name',
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
              ),
              Button(
                title: 'Update',
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  _firestore.collection('users').doc(loggedInUser.uid).update(
                      {'nickName': nickName, 'userUid': loggedInUser.uid});
                  setState(() {
                    showSpinner = false;
                  });
                },
              )
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
