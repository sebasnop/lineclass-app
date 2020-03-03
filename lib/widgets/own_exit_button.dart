import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnExitButton extends StatefulWidget {

  double width;
  double height;
  String exitText;

  OwnExitButton({
    Key key,
    @required this.width,
    @required this.height,
    @required this.exitText
  });

  @override
  _OwnExitButtonState createState() => _OwnExitButtonState();
}

class _OwnExitButtonState extends State<OwnExitButton> {
  @override
  Widget build(BuildContext context) {

    return Row( //App Bar
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 19,),
          child: Text(
            widget.exitText,
            style: TextStyle(
                color: Color(0xff686868),
                fontSize: 20,
                fontWeight: FontWeight.w300
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.only(bottom: 20, right: 5),
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: IconButton(
                icon: Icon(CupertinoIcons.right_chevron, color: Color(0xff686868), size: 40,),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
                }
            ),
          ),
        )


      ],
    );
  }
}