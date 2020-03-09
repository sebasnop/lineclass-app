import 'package:flutter/material.dart';
import 'package:lineclass/widgets/own_exit_button.dart';

class JoinedCourseScreen extends StatelessWidget {

  String courseName;

  JoinedCourseScreen({@required this.courseName});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double backButtonWidth = screenWidth*0.20;

    double screenHeight = MediaQuery.of(context).size.height;

    Widget copyCourseText = Container(
      margin: EdgeInsets.only(bottom: screenHeight*0.08),
      child: Text(
        "¡Enhorabuena! \nEntraste al curso",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40,
            color: Color(0xff686868),
            fontFamily: "Comfortaa"
        ),
      ),
    );

    Widget codeCourseBox = Container (
      margin: EdgeInsets.only(bottom: screenHeight*0.03),
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
            courseName,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          copyCourseText,
          codeCourseBox,
          OwnExitButton(height: backButtonWidth, width: backButtonWidth, exitText: "Salir")
        ],
      ),
    );
  }

}
