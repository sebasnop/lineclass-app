import 'package:flutter/material.dart';

class GreenButton extends StatefulWidget {

  final String buttonText;

  double topMargin;
  double bottomMargin;

  GreenButton({
    Key key,
    @required this.buttonText,
    @required this.topMargin,
    @required this.bottomMargin,
  });

  @override
  _GreenButtonState createState() => _GreenButtonState();
}

class _GreenButtonState extends State<GreenButton> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth*0.80;

    return Container(
      height: 50,
      width: buttonWidth,
      margin: EdgeInsets.only(
          top: widget.topMargin,
          bottom: widget.bottomMargin
      ),
      child: InkWell(
        onTap: (){

        },
        child: Container(
          height: 50.0,
          width: buttonWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  colors: [
                          Color(0xFF1E56A0),
                          Color(0xFF4EC2E0)
                  ]
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(2, 2)
                )
              ]
          ),

          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(left: 35,right: 20),
                  child: Icon(Icons.favorite, color: Colors.white,size: 32,),
                ),
                Text(
                  widget.buttonText,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Comfortaa",
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),

                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

}