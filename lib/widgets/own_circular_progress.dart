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

    if (height == null){height = 100;}
    if (width == null){width = 100;}

    return Container(
        padding: EdgeInsets.only(
            bottom: 20
        ),
        color: Colors.transparent,
        height: height,
        width: width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          strokeWidth: 7,
          backgroundColor: Colors.white,
        )
    );
  }

}