import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Publication/ui/screens/create_publication_screen.dart';
import 'package:lineclass/Publication/ui/widgets/publications_list.dart';
import 'package:lineclass/User/model/user.dart';
import 'file:///C:/Users/Programacion/Documents/lineclass/lib/widgets/buttons/fab.dart';

class PublicationsScreen extends StatelessWidget {

  final User user;
  final Course course;

  const PublicationsScreen({Key key, @required this.user, @required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Container title = Container(
      padding: EdgeInsets.only(left:30, top: 20, bottom: 30),
      child: Text(
        "Novedades",
        style: TextStyle(
          fontSize: 26,
          fontFamily: "Comfortaa",
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          shrinkWrap: true,
          children: <Widget>[
            title,
            PublicationsList(course: course, user: user)
          ],
        ),
      ),
      floatingActionButton: Fab(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => CreatePublicationScreen(user: user, course: course,)
          ));
        },
        icon: Icons.edit,
        iconSize: 35,
      ),
    );
  }
}
