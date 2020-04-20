import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCourse extends StatelessWidget {

  final double headerHeight;

  const SearchCourse({Key key, @required this.headerHeight}) : super(key: key); // Currently 200

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    Container blueContainer = Container(
      color: Color(0xFF1E56A0),
      width: screenWidth,
      height: 50,
    );

    Text youCourses = Text (
      "Tus Cursos",
      style: TextStyle(
        fontSize: 24,
        fontFamily: "Comfortaa",
        fontWeight: FontWeight.w500
      ),
    );

    Container whiteContainer = Container(
      width: screenWidth,
      height: 100, //100, but in the future will be 162
      margin: EdgeInsets.only(top:20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, offset: Offset(0, -5), blurRadius: 20)
        ]
      ),
      child: youCourses,
      padding: EdgeInsets.only(left: 30, top: 40),
    );

    return Stack(
      children: <Widget>[
        blueContainer,
        whiteContainer
      ],
    );

  }
}
