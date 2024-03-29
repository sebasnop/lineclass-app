import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/screens/course_screen.dart';
import 'package:lineclass/User/model/user.dart';

class CourseCard extends StatelessWidget {

  final Course course;
  final User user;
  final List <String> noCourseMessages;

  CourseCard({Key key, this.course, this.user, this.noCourseMessages});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    Border border = Border(top: BorderSide(width: 0.3, color: Colors.black12), );

    IconData temathicIcon;

    if (course != null){

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
        default: temathicIcon = Icons.all_inclusive;
      }

    } else {

      switch (noCourseMessages[2]) {
        case "empty" : temathicIcon = Icons.favorite;
        break;
        case "error" : temathicIcon = Icons.error_outline;
        break;
        default: temathicIcon = Icons.all_inclusive;
      }

    }

    Icon icon = Icon (temathicIcon, color: Colors.black87, size:  40,);

    Widget finalIcon = Container(
      height: 90,
      width: 90,
      child: Center(child: icon),
      color: Colors.white,
    );

    Widget text (String courseName,) {
      return Container(
        height: 90,
        width: screenWidth - 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(courseName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
          ],
        ),
      );
    }

    Widget text1 (String courseName, String courseOwner) {
      return Container(
        height: 90,
        width: screenWidth - 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(courseName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            Text("", style: TextStyle(fontSize: 4,)),
            Text(courseOwner,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),)
          ],
        ),
      );
    }

    Widget courseCard (){

      return InkWell(
        child: Container(
          height: 90,
          width: screenWidth,
          decoration: BoxDecoration(color: Colors.white, border: border),
          child: Row(
            children: <Widget>[
              finalIcon,
              text(course.name, /**userSnapshot["name"]**/)
            ],
          ),
        ),
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute (
              builder: (BuildContext context) => CourseScreen(course:course, user: user,)
          ));
        }

        ,
      );

    }

    Widget noCourseCard (List <String> messages){

      return Container(
        height: 90,
        width: screenWidth,
        decoration: BoxDecoration(color: Colors.white, border: border),
        child: Row(
          children: <Widget>[
            finalIcon,
            text1(messages[0], messages[1])
          ],
        ),
      );

    }

    if (course != null) {

      return courseCard();

    } else {

      return noCourseCard(noCourseMessages);

    }



  }
}
