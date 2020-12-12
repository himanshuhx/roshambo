import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kHeadingTextStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w900,
);

const kBottomSheetTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25,
  color: Colors.white,
);

const kGameHeadingStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w900,
  color: Color(0xff1B192D),
);

const kGameButtonTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kTextFieldStyle = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffFB5757), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffFB5757), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
);
