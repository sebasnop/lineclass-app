import 'package:flutter/material.dart';

class OwnCircularProgress extends StatelessWidget{

  final double height;
  final double width;

  OwnCircularProgress({
    Key key,
    @required this.height,
    @required this.width
  });

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.only(
            bottom: 20
        ),
        color: Colors.transparent,
        height: height,
        width: width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          backgroundColor: Colors.white,
        )
    );
  }

}