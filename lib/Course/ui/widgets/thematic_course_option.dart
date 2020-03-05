import 'package:flutter/material.dart';

class ThematicCourseOption extends StatelessWidget {

  final String text;
  final IconData icon;

  ThematicCourseOption({Key key, @required this.text, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      value: "math",
      child: Container(
          child: Row(
            children: <Widget>[
              Container (
                padding: EdgeInsets.only(right: 15),
                child: Icon(icon, color: Colors.black87)
              ),
              Text(
                text,
                style: TextStyle(fontFamily: "Comfortaa", color: Colors.black),
              ),
            ]
          )
      ),
    );
  }
}
