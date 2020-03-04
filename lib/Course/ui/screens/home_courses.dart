import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/screens/add_course_screen.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/user_welcome.dart';
import 'package:lineclass/widgets/own_app_bar.dart';
import 'package:lineclass/widgets/fab.dart';

class HomeCourses extends StatelessWidget {

  double appBarHeight = 80; //Medida de altura de Material Design

  User user = User(
      name: "William",
      photoUrl: "assets/avatar.png"
  );

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: <Widget>[
          OwnAppBar(
            width: screenWidth,
            height: appBarHeight,
          ),
          UserWelcome(
            welcomeText: "Bienvenido, ",
            user: user,
            screenWidth: screenWidth,
          )
        ],
      ),
      floatingActionButton: Fab(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute (
              builder: (BuildContext context) => AddCourseScreen()
          ));
        },
        icon: Icons.add,
        iconSize: 50,
      ),
    );
  }
}
