import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Publication/ui/screens/create_publication_screen.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/widgets/fab.dart';

class PublicationsScreen extends StatelessWidget {

  final User user;
  final Course course;

  const PublicationsScreen({Key key, @required this.user, @required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          shrinkWrap: true,
          children: <Widget>[
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
