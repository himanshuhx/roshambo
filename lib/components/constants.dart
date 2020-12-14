import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kHeadingTextStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w900,
);

const kBottomSheetTextStyle = TextStyle(
  fontWeight: FontWeight.w200,
  fontSize: 20,
  color: Colors.white,
  letterSpacing: 1.2,
  fontFamily: 'Russo One',
);

const kGameOverTextStyle = TextStyle(
  fontSize: 50,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontFamily: 'Russo One',
);

const kGameCardStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 14,
  fontFamily: 'Ubuntu',
  color: Colors.white70,
);

const kNickNameStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  fontFamily: 'Pacifico',
  color: Colors.white,
  letterSpacing: 3,
);

const kGameHeadingStyle = TextStyle(
  fontFamily: 'Orbitron',
  fontSize: 22,
  fontWeight: FontWeight.w900,
  color: Color(0xff1B192D),
  letterSpacing: 1.5,
);

const kGameButtonTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black54,
  fontFamily: "Russo One",
  letterSpacing: 2,
);

const kTextFieldStyle = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
);
