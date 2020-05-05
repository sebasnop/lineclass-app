import 'package:flutter/material.dart';
import 'package:lineclass/Content/model/content.dart';

class CreateContentCard extends StatelessWidget {

  final double screenWidth;
  final Content content;
  final IconData iconData;

  const CreateContentCard({Key key, @required this.screenWidth,
    @required this.content, @required this.iconData}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Widget row = Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Icon(iconData)
        ),
        Text(content.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),)
      ],
    );

    return Container (
        alignment: Alignment.centerLeft,
        height: 40,
        width: screenWidth,
        padding: EdgeInsets.only(left: 30,),
        child: row
    );
  }
}
