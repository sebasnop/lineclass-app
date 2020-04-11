import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Publication/ui/screens/publications_screen.dart';
import 'package:lineclass/widgets/fab.dart';

// ignore: must_be_immutable
class CourseScreen extends StatelessWidget {

  Course course;

  CourseScreen({Key key, @required this.course});

  List<Widget> containers = [
    PublicationsScreen(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.blueAccent,
    )
  ];

  @override
  Widget build(BuildContext context) {

    List <String> courseNameList = course.name.split(" ");

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(courseNameList[0], style: TextStyle(fontFamily: "Comfortaa")),
            leading: InkWell(
              child: Icon(
                Icons.keyboard_arrow_left,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
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