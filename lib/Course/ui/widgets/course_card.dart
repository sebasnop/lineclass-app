import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/screens/course_screen.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class CourseCard extends StatelessWidget {

  final Course course;
  final List <String> noCourseMessages;

  CourseCard({Key key, this.course, this.noCourseMessages});

  Stream <DocumentSnapshot> getUser (String userUid) {
    Stream <DocumentSnapshot> userSnapshot = Firestore.instance.collection("users").document(userUid).snapshots();
    return userSnapshot;
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    Border border = Border(top: BorderSide(width: 0.7, color: Colors.black12), );

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

    Widget text (String courseName, String courseOwner) {
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

    Widget courseCard (DocumentSnapshot userSnapshot){

      return InkWell(
        child: Container(
          height: 90,
          width: screenWidth,
          decoration: BoxDecoration(color: Colors.white, border: border),
          child: Row(
            children: <Widget>[
              finalIcon,
              text(course.name, userSnapshot["name"])
            ],
          ),
        ),
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute (
              builder: (BuildContext context) => CourseScreen(course:course)
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
            text(messages[0], messages[1])
          ],
        ),
      );

    }

    if (course != null) {

      Stream<DocumentSnapshot> getUserOwner = getUser(course.courseOwner.documentID);

      return Container(
        child: StreamBuilder(
          stream: getUserOwner,
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return OwnCircularProgress(height: 100, width: 100);
              case ConnectionState.done:
                return courseCard(snapshot.data);
              case ConnectionState.active:
                return courseCard(snapshot.data);
              case ConnectionState.none:
                return OwnCircularProgress(height: 100, width: 100);
              default:
                return OwnCircularProgress(height: 100, width: 100);
            }

          },
        ),
      );

    } else {

      return noCourseCard(noCourseMessages);

    }



  }
}
