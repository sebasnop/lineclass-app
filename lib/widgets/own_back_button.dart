import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnBackButton extends StatefulWidget {

  double width;
  double height;
  String backText;

  OwnBackButton({
    Key key,
    @required this.width,
    @required this.height,
    @required this.backText
  });

  @override
  _OwnBackButtonState createState() => _OwnBackButtonState();
}

class _OwnBackButtonState extends State<OwnBackButton> {
  @override
  Widget build(BuildContext context) {

    return Row( //App Bar
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 5.0),
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: IconButton(
                icon: Icon(CupertinoIcons.left_chevron, color: Color(0xff686868), size: 40,),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
          ),
        ),

        Container(
              padding: EdgeInsets.only(top: 24, left: 5,),
              child: Text(
                widget.backText,
                style: TextStyle(
                  color: Color(0xff686868),
                  fontSize: 20,
                  fontWeight: FontWeight.w300
                ),
              ),
            )


      ],
    );
  }
}
