import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/screens/add_course_screen.dart';
import 'package:lineclass/Course/ui/widgets/your_courses.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/user_welcome.dart';
import 'package:lineclass/widgets/own_app_bar.dart';
import 'package:lineclass/widgets/fab.dart';

class HomeCourses extends StatelessWidget {

  double appBarHeight = 80; //Medida de altura de Material Design

  User user = User(
      firstName: "Sebastian",
      name: "Sebastian Valencia",
      photoUrl: "assets/avatar.png"
  );

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          OwnAppBar(
            width: screenWidth,
            height: appBarHeight,
          ),
          SizedBox(
            width: screenWidth,
            height: screenHeight-80,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                UserWelcome(
                  welcomeText: "Bienvenido, ",
                  user: user,
                  screenWidth: screenWidth,
                ),
                YourCourses(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Fab(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute (
              builder: (BuildContext context) => AddCourseScreen(user: user)
          ));
        },
        icon: Icons.add,
        iconSize: 50,
      ),
    );
  }
}
