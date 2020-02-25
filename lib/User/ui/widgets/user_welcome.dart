import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/profileAvatar.dart';

class UserWelcome extends StatelessWidget {

  String welcomeText;
  double screenWidth;

  User user;

  UserWelcome({
    Key key,
    @required this.welcomeText,
    @required this.user,
    @required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {

    double width = (this.screenWidth*75)/100;
    double widthText = (width*75)/100;
    double widthPhoto = (width*25)/100;

    Widget welcome = Container(
        padding: EdgeInsets.only(
            bottom: 8
        ),
        child: Text(
          welcomeText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w100,
            fontSize: 18,
        ),
      )
    );

    Widget name = Text(
      user.name,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );

    Widget welcomeAndName = Container(
        width: widthText,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            welcome,
            name
        ]
      )
    );

    return Container(
      width: width,
      margin: EdgeInsets.only(
        left: 45,
        top: 35,
        right: 45,
        bottom: 40
      ),
      child: Row(
        children: <Widget>[
          welcomeAndName,
          ProfileAvatar(
            //user: user,
            width: widthPhoto,
            height: widthPhoto,
          )
        ],
      ),
    );
  }
}
