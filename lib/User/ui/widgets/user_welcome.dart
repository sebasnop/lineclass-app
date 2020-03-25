import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/avatar_picture.dart';

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

    double usedWidth = this.screenWidth*0.75;
    double unusedWidth = this.screenWidth*0.25;
    double widthText = usedWidth*0.85;
    double widthPhoto = usedWidth - widthText;

    Widget welcome = Container(
        child: Text(
          welcomeText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w100,
            fontSize: 20,
        ),
      )
    );

    Widget name = Text(
      "Sebastian!",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );

    Widget welcomeAndName = Container(
        padding: EdgeInsets.only(left: 20),
        width: widthText,
        child: Row(
          children: <Widget>[
            welcome,
            name
        ]
      )
    );

    Widget textAndPhoto = Container (
      width: usedWidth,
      margin: EdgeInsets.only(
        left: unusedWidth/2,
        right: unusedWidth/2,
        top: 35,
        bottom: 35
      ),
      child: Row(
        children: <Widget>[
          AvatarPicture(
            side: widthPhoto,
            user: user,
          ),
          welcomeAndName,
        ],
      ),
    );

    return Container(
            width: screenWidth,
            child: textAndPhoto
        );
  }
}
