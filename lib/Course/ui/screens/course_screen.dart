import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/widgets/fab.dart';

// ignore: must_be_immutable
class CourseScreen extends StatelessWidget {

  Course course;

  CourseScreen({Key key, @required this.course});

  List<Widget> containers = [
    Scaffold(
      body: Container(
        color: Colors.white,
      ),
      floatingActionButton: Fab(
        onPressed: () {
          /**Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => AddCourseScreen(user: user)
              ));**/
        },
        icon: Icons.edit,
        iconSize: 35,
      ),
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.blueAccent,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(course.name, style: TextStyle(fontFamily: "Comfortaa")),
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