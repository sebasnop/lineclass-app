import"package:flutter/material.dart";
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/screens/user_settings_screen.dart';
import 'package:lineclass/User/ui/widgets/user_welcome.dart';

class HomeHeader extends StatelessWidget {

  User user;

  HomeHeader({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double side = screenWidth*0.08;
    double half = screenWidth/2;
    double part = half - side;

    Widget appAndConfig = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 50, left: screenWidth*0.08, right: screenWidth*0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: part,
            child: Text(
              "Lineclass",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Comfortaa"
              ),
            ),
          ),
          Container(
            width: part,
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => UserSettingsScreen()
                ));
              },
              child: Icon(Icons.settings, color: Colors.white70, size: 20,),
            ),
          )
        ],
      ),
    );

    return Container(
      width: screenWidth,
      height: 224,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0,-0.5),
            end: Alignment(0,1),
              colors: [
                Color(0xFF36C186),
                Color(0xFF158A8C)
              ]
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          appAndConfig,
          UserWelcome(
            welcomeText: "¡Hola ",
            user: user,
            screenWidth: screenWidth,),
          Container(
            margin: EdgeInsets.only(top: 31),
            height: 20,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
            ),
          ),
        ],
      ),
    );
  }
}
