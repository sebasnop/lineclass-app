import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GrayButton extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;
  final IconData iconData;
  final double width;

  const GrayButton({Key key, @required this.buttonText, @required this.onPressed,
    @required this.iconData, @required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 36,
      width: width,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: MaterialButton(
        padding: EdgeInsets.only(left: 12, right: 18),
        color: Color(0xFFf6f6f6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 6, bottom: 9, right: 8),
              child: Icon(iconData, color: Color(0xFF686868),)
            ),
            Container(
              margin: EdgeInsets.only(top: 9, bottom: 5.4,),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontFamily: "Comfortaa",
                  fontSize: 16,
                  color: Color(0xFF686868)
                ),
              ),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
