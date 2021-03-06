import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.title, this.color, this.onPressed});

  String title;
  Color color;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Material(
        elevation: 10,
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onPressed,
          height: 20,
          minWidth: 300,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Ubuntu',
            ),
          ),
        ),
      ),
    );
  }
}
