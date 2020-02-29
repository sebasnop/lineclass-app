import 'package:flutter/material.dart';


class BlueButton extends StatelessWidget {



  final String buttonText;
  final VoidCallback onPressed;

  BlueButton({
    Key key,
    @required this.buttonText,
    @required this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth*0.90;

    return Container(
      height: 50,
        margin: EdgeInsets.only(
          top: screenHeight*0.28,
          bottom: 50
        ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50.0,
          width: buttonWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF49CCB9),
                    Color(0xFF4EC2E0)
                  ]
              )

          ),

          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: "Comfortaa",
                  color: Colors.white,
                fontWeight: FontWeight.bold
              ),

            ),
          ),

        ),
      ),
    );
  }

}