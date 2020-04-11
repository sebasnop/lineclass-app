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
    return Scaffold(
      body: Container(
        color: Colors.white,
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
