import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/widgets/own_exit_button.dart';

class CopycodeCourseScreen extends StatelessWidget {

  String code;

  CopycodeCourseScreen({Key key, this.code});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double backButtonWidth = screenWidth*0.20;

    double screenHeight = MediaQuery.of(context).size.height;

    Widget copyCourseText = Container(
      margin: EdgeInsets.only(top: screenHeight*0.30, bottom: screenHeight*0.30),
        child: Text(
          "El código \ndel curso es",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40,
              color: Color(0xff686868),
              fontFamily: "Comfortaa"
          ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          copyCourseText,
          OwnExitButton(height: backButtonWidth, width: backButtonWidth, exitText: "Salir")
        ],
      ),
    );
  }

}
