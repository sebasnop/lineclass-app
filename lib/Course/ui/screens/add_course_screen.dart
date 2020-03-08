import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/screens/create_course_screen.dart';
import 'package:lineclass/Course/ui/screens/join_course_screen.dart';
import 'package:lineclass/Course/ui/widgets/add_course_option.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:lineclass/widgets/own_back_button.dart';

class AddCourseScreen extends StatelessWidget {

  User user;

  AddCourseScreen({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double backButtonWidth = screenWidth*0.20;

    double screenHeight = MediaQuery.of(context).size.height;

    Widget addCourseText = Container(
      margin: EdgeInsets.only(top: 30, bottom:25),
      child: Center(
        child: Text(
          "Añadir Curso",
          style: TextStyle(
            fontSize: 30,
            color: Color(0xff686868),
            fontFamily: "Comfortaa"
          ),
        ),
      ),
    );

    Widget asText = Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Center(
        child: Text(
          "Como:",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xff686868),
              fontFamily: "Comfortaa"
          ),
        ),
      ),
    );

     Function createCourse =  (){
      Navigator.push(context, MaterialPageRoute (
          builder: (BuildContext context) => CreateCourseScreen(user: user)
      ));
    };

    Function joinCourse =  (){
      Navigator.push(context, MaterialPageRoute (
          builder: (BuildContext context) => JoinCourseScreen(user: user)
      ));
    };

    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        children: <Widget>[
          OwnBackButton(width: backButtonWidth, height: backButtonWidth, backText: "Volver"),
          addCourseText,
          asText,
          AddCourseOption(optionText: "PROFESOR", optionImage: "assets/teacher.png",
            screenWidth: screenWidth, screenHeight: screenHeight, goTo: createCourse,),
          AddCourseOption(optionText: "ESTUDIANTE", optionImage: "assets/student.png",
            screenWidth: screenWidth, screenHeight: screenHeight, goTo: joinCourse,)
        ],
      ),
    );
  }
}
