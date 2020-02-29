import "package:flutter/material.dart";
import 'package:lineclass/widgets/own_circular_progress.dart';

class LoadingScreen extends StatelessWidget {

  final String text;

  LoadingScreen({
    Key key,
    @required this.text
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OwnCircularProgress(
                  height: 100,
                  width: 100,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                )
              ],
            )
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF49CCB9),
                      Color(0xFF4EC2E0)
                    ]
                )

            )
        )
    );
  }

}

