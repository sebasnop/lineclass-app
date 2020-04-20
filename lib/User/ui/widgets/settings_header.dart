import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/avatar_picture.dart';

class SettingsHeader extends StatelessWidget {

  final User user;

  SettingsHeader({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double side = screenWidth*0.06;
    double boxWidth = screenWidth-(side*2);

    Widget name = Container(
      margin: EdgeInsets.only(bottom: 3, top: 10),
      child: Text(
        "${user.firstName} ${user.firstLastName ?? ""}",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: "Comfortaa",
          fontWeight: FontWeight.w600
        ),
      )
    );

    Text nickname = Text(
      "@${user.nickname}",
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontFamily: "Comfortaa",
          fontWeight: FontWeight.w300
      ),
    );

    Widget text = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        name,
        nickname
      ],
    );

    Container box = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:20, bottom: 30, left: side, right: side),
      height: 150,
      width: screenWidth-(side*2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow (
                color:  Colors.black12,
                blurRadius: 10,
                offset: Offset(2, 3)
            )
          ]
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        onTap: (){

        },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AvatarPicture(side: boxWidth*0.17, user: user,),
              Container(child:text, alignment: Alignment.center,)
            ]
        ),
    )
    );

    return Stack(
      children: <Widget>[
        Container(color: Color(0xFF1E56A0), height: 120, width: screenWidth,),
        box
      ],
    );

  }
}
