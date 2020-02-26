import 'package:flutter/material.dart';

class AddCourseOption extends StatefulWidget {

  String optionText;
  String optionImage;

  double screenWidth;
  double screenHeight;

  AddCourseOption({
    Key key,
    @required this.optionText,
    @required this.optionImage,
    @required this.screenWidth,
    @required this.screenHeight
  });

  @override
  _AddCourseOptionState createState() => _AddCourseOptionState();
}

class _AddCourseOptionState extends State<AddCourseOption> {
  @override
  Widget build(BuildContext context) {

    double containerWidth = widget.screenWidth*0.80;
    double containerHeight = widget.screenHeight*0.48;

    double sidePicture = containerHeight*0.50;

    Widget picture = Container(
      margin: EdgeInsets.only(top: 20, bottom: 15),
      width: sidePicture,
      height: sidePicture,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(widget.optionImage),
          )
      ),
    );

    Widget option = Container(
      child: Text(
        widget.optionText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 15
      ),
      child: AnimatedContainer(
        height: containerHeight,
        width: containerWidth,
        duration: Duration(seconds: 2),
        curve: Curves.easeIn,
        child: Material(
          elevation: 2,
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: () {

            },
            child: Center(
              child: Column(
                children: <Widget>[
                  picture,
                  option
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
