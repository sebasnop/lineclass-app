import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/widgets/own_back_button.dart';

class OwnAppBar extends StatelessWidget {

  String title;

  OwnAppBar({
    Key key,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double heightSafeArea = 24;
    double heightBar = 80 - heightSafeArea;

    Widget safeArea = Container(
      height: heightSafeArea,
      width: screenWidth,
      color: Colors.white
    );

    Widget backButton = Container(
      padding: EdgeInsets.only(left: 5),
      child: SizedBox(
        height: heightBar,
        width: heightBar,
        child: IconButton(
            icon: Icon(CupertinoIcons.left_chevron, color: Color(0xff686868), size: 40,),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
    );

    Widget titleText = Container (
      height: heightBar,
      width: screenWidth,
      alignment: Alignment.center,
      child: Text (
      title,
        style: TextStyle(
          fontFamily: "Comfortaa",
          fontSize: 20,
          color: Color(0xFF686868),
        ),
      ),
    );

    Widget bar = Container(
      height: heightBar,
      color: Colors.white,
      width: screenWidth,
      child: Stack(
        children: <Widget>[
          titleText,
          backButton,
        ],
      ),
    );

    return Container(
      width: screenWidth,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow (
                color:  Colors.black38,
                blurRadius: 2
            )
          ]
      ),
      child: Column(
        children: <Widget>[
          safeArea,
          bar
        ],
      )
    );
  }
}
