import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/avatar_picture.dart';

class SettingsHeader extends StatelessWidget {

  User user;

  SettingsHeader({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double side = screenWidth*0.06;
    double width = screenWidth-(side*2);

    double usedWidth = width*0.75;
    double unusedWidth = width*0.25;
    double widthText = usedWidth*0.80;
    double widthPhoto = usedWidth - widthText;

    return Container(
      height: screenHeight*0.20,
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        onTap: (){

        },
        child: Container(
          padding: EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF36C186),
                    Color(0xFF158A8C)
                  ]
              ),
            boxShadow: <BoxShadow>[
              BoxShadow (
                  color:  Colors.black26,
                  blurRadius: 1,
                  offset: Offset(2, 3)
              )
            ]
          ),
          height: screenHeight*0.12,
          width: screenWidth-(side*2),
          child: Row(
            children: <Widget>[
              AvatarPicture(side: widthPhoto, user: user,)
            ]
        ),
      ),
    )
    );
  }
}
