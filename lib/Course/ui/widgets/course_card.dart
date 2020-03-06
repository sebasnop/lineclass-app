import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';

class CourseCard extends StatelessWidget {

  Course course;

  CourseCard({Key key, this.course});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    Border border = Border(top: BorderSide(width: 0.7, color: Colors.black12), );

    IconData temathicIcon;

    switch (course.thematic) {
      case "math" : temathicIcon = Icons.equalizer;
        break;
      case "science" : temathicIcon = Icons.filter_hdr;
        break;
      case "tech" : temathicIcon = Icons.devices;
        break;
      case "languages" : temathicIcon = Icons.forum;
        break;
      case "sports" : temathicIcon = Icons.directions_run;
        break;
      case "society" : temathicIcon = Icons.account_balance;
        break;
      case "art" : temathicIcon = Icons.color_lens;
        break;
      case "music" : temathicIcon = Icons.audiotrack;
        break;
      case "other" : temathicIcon = Icons.all_inclusive;
        break;
      case "empty" : temathicIcon = Icons.favorite;
        break;
      default: temathicIcon = Icons.all_inclusive;
    }

    Icon icon = Icon (temathicIcon, color: Colors.black87, size:  40,);

    Widget finalIcon = Container(
      height: 90,
      width: 90,
      child: Center(child: icon),
      color: Colors.white,
    );

    Widget text = Container(
      height: 90,
      width: screenWidth - 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(course.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
          Text("", style: TextStyle(fontSize: 4,)),
          Text(course.courseOwner, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),)
        ],
      ),
    );

    return Container(
      height: 90,
      width: screenWidth,
      decoration: BoxDecoration(color: Colors.white, border: border),
      child: Row(
        children: <Widget>[
          finalIcon,
          text
        ],
      ),
    );
  }
}
