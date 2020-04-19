import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/screens/home_courses.dart';
import 'package:lineclass/User/model/user.dart';

class NavigationDrawer extends StatefulWidget {

  final User user;

  NavigationDrawer({Key key, @required this.user});

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1E56A0),
        title: Text("Lineclass", style: TextStyle(fontFamily:"Comfortaa", fontWeight: FontWeight.w600),),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Guaco"),
              onTap: (){},
            )
          ],
        ),
      ),
      body: HomeCourses(user: widget.user),
    );
  }
}
