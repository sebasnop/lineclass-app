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

    double usedWidth = (this.screenWidth*75)/100;
    double unusedWidth = (this.screenWidth*25)/100;
    double widthText = (usedWidth*72)/100;
    double widthPhoto = usedWidth - widthText;

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
          welcomeAndName,
          AvatarPicture(
            side: widthPhoto,
            user: user,
          )
        ],
      ),
    );

    return Container(
      width: screenWidth,
      child: textAndPhoto
    );
  }
}
