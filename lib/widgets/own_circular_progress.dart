import 'package:flutter/material.dart';

class OwnCircularProgress extends StatelessWidget{

  double height;
  double width;

  OwnCircularProgress({
    Key key,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.only(
            bottom: 20
        ),
        color: Colors.transparent,
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          backgroundColor: Colors.white,
        )
    );
  }

}