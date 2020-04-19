import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/screens/add_course_screen.dart';
import 'package:lineclass/Course/ui/widgets/search_course.dart';
import 'package:lineclass/Course/ui/widgets/student_courses_list.dart';
import 'package:lineclass/Course/ui/widgets/teacher_courses_list.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/home_header.dart';
import 'package:lineclass/widgets/fab.dart';

class HomeCourses extends StatelessWidget {

  final User user;

  HomeCourses ({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          //HomeHeader(user: user),
          SearchCourse(),
          SizedBox(
            width: screenWidth,
            height: screenHeight - 274 - 55,
            child: ListView(
              padding: EdgeInsets.only(top: 20, bottom: 0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                StudentCoursesList(user: user),
                TeacherCoursesList(user: user)
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Fab(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => AddCourseScreen(user: user)
          ));
        },
        icon: Icons.add,
        iconSize: 50,
      ),
    );
  }

}