import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/widgets/your_courses_list.dart';

class YourCourses extends StatefulWidget {
  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
  @override
  Widget build(BuildContext context) {

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
