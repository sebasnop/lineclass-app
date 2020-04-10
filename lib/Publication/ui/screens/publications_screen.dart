import 'package:flutter/material.dart';
import 'package:lineclass/widgets/fab.dart';

class PublicationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
