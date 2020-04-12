import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Publication/ui/screens/publications_screen.dart';
import 'package:lineclass/User/model/user.dart';

// ignore: must_be_immutable
class CourseScreen extends StatelessWidget {

  Course course;
  User user;

  CourseScreen({Key key, @required this.course, @required this.user});

  @override
  Widget build(BuildContext context) {

    List<Widget> containers = [
      PublicationsScreen(course: course, user: user,),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.blueAccent,
      )
    ];

    List <String> courseNameList = course.name.split(" ");

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(courseNameList[0], style: TextStyle(fontFamily: "Comfortaa")),
            leading: InkWell(
              child: Icon(
                Icons.keyboard_arrow_left,
                size: 24,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              indicatorColor: Color(0xff1e56a0),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.collections_bookmark),
                ),
                Tab(
                  icon: Icon(Icons.calendar_today),
                ),
                Tab(
                  icon: Icon(Icons.people),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: containers,
          ),
        ),
      ),
    );
  }
}