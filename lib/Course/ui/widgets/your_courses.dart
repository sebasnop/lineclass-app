import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/widgets/your_courses_list.dart';
import 'package:lineclass/User/model/user.dart';

class YourCourses extends StatefulWidget {

  final User user;

  YourCourses ({Key key, this.user});

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
                  YourCoursesList(user: widget.user),
                ],
              ),
            )
          ]
        )
      ],
    );
  }
}
