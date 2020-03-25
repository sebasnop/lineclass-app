import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/Course/ui/widgets/your_courses_list.dart';

class YourCourses extends StatefulWidget {
  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget> [
            SizedBox(
              height: screenHeight*0.53,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  YourCoursesList(),
                ],
              ),
            )
          ]
        )
      ],
    );
  }
}
