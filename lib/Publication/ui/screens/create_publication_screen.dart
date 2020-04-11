import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/User/model/user.dart';

class CreatePublicationScreen extends StatefulWidget {

  final User user;
  final Course course;

  CreatePublicationScreen({Key key, @required this.user, @required this.course});

  @override
  _CreatePublicationScreenState createState() => _CreatePublicationScreenState();
}

class _CreatePublicationScreenState extends State<CreatePublicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf6f6f6),
        elevation: 2,
        title: Text("Agregar Contenido", style: TextStyle(fontFamily: "Comfortaa", fontSize: 16)),
        leading: InkWell(
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 24,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  "Publicar",
                  style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontSize: 16,
                      color: Color(0xFF1E56A0),
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

