import 'package:flutter/material.dart';

class SearchCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double side = screenWidth*0.08;
    double half = screenWidth/2;
    double part = half - side;

    return Container(
      margin: EdgeInsets.only(top: 5,),
      padding: EdgeInsets.only(left: screenWidth*0.09, top: 10),
      height: 45,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Color(0xFFf3f3f3),
      ),
      child: Row(
          children: <Widget> [
            Container(
              alignment: Alignment.topLeft,
                width: part,
                height: 45,
                child: Text("Tus Cursos", style: TextStyle (color: Color(0xFF8c8c8c), fontSize: 22),)
            ),
            Container(
              alignment: Alignment.topRight,
                width: part,
                child: Icon(Icons.search, color: Colors.black45,),
            )
          ]),
    );
  }
}
