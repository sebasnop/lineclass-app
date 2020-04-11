import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/widgets/own_exit_button.dart';

class JoinedCourseScreen extends StatelessWidget {

  Course course;

  JoinedCourseScreen({@required this.course});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double backButtonWidth = screenWidth*0.20;

    double screenHeight = MediaQuery.of(context).size.height;

    Widget greatText = Container(
      margin: EdgeInsets.only(bottom: screenHeight*0.08),
      child: Text(
        "¡Enhorabuena!",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w500,
            color: Color(0xff686868),
            fontFamily: "Comfortaa"
        ),
      ),
    );

    Widget courseOfText = Container(
      margin: EdgeInsets.only(bottom: screenHeight*0.08),
      child: Text(
        "Entraste al \ncurso de...",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w100,
            color: Color(0xff686868),
            fontFamily: "Comfortaa"
        ),
      ),
    );

    /**Widget nameCourseBox = Container (
      margin: EdgeInsets.only(bottom: screenHeight*0.1),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: screenHeight*0.08,
            width: screenWidth*0.85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
                //border: Border.all(color: Color(0xff36C186), width: 1.5),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  //BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 1)
                ]
            ),
          ),
          Text(
            course.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );**/

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          greatText,
          courseOfText,
          CourseCard(course: course),
          Container(height: screenHeight*0.1,),
          //nameCourseBox,
          OwnExitButton(height: backButtonWidth, width: backButtonWidth, exitText: "Salir")
        ],
      ),
    );
  }

}
