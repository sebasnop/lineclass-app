import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/Course/ui/widgets/your_courses_list.dart';

class YourCourses extends StatefulWidget {
  @override
  _YourCoursesState createState() => _YourCoursesState();
}

class _YourCoursesState extends State<YourCourses> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    BorderSide borderShape = BorderSide(color: Color(0xff36C186), width: 2);

    return Stack(
      children: <Widget>[
        Container(
          height: 71,
          width: screenWidth,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              border: Border.fromBorderSide(borderShape)
          ),
        ),
        Column(
          children: <Widget> [
            Container(
              margin: EdgeInsets.only(top: 27, left: 2),
              padding: EdgeInsets.only(left: screenWidth*0.09, top: 10),
              height: 45,
              width: screenWidth-4,
              decoration: BoxDecoration(
                color: Color(0xFFf3f3f3),
              ),
              child: Text("Tus Cursos", style: TextStyle (color: Color(0xFF8c8c8c), fontSize: 22),),
            ),
            SizedBox(
              height: screenHeight*0.53,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  YourCoursesList(),
                  /**CourseCard(course: Course(thematic: "math", courseOwner: "David Blanquez Sanz", creationDate: Timestamp.now(),
                      name: "Cálculo Diferencial", institution: "IE Colegio Loyola", code: "williambiologia"),),
                  CourseCard(course: Course(thematic: "math", courseOwner: "Diego Mejía Duque", creationDate: Timestamp.now(),
                      name: "Geometría Vectorial y Analítica", institution: "IE Colegio Loyola", code: "williambiologia"),),
                  CourseCard(course: Course(thematic: "tech", courseOwner: "Jovani Alberto Jiménez", creationDate: Timestamp.now(),
                      name: "Introducción a la Ingeniería de Sistemas e Informática", institution: "IE Colegio Loyola", code: "williambiologia"),),
                  CourseCard(course: Course(thematic: "society", courseOwner: "Jesus de Nazareth", creationDate: Timestamp.now(),
                      name: "Cátedra Ingenierías Facultad de Minas", institution: "IE Colegio Loyola", code: "williambiologia"),),
                  CourseCard(course: Course(thematic: "society", courseOwner: "Online", creationDate: Timestamp.now(),
                      name: "Cátedra Nacional de Inducción y Preparación para la Vida Universitaria", institution: "IE Colegio Loyola", code: "williambiologia"),),**/

                  /**CourseCard(course: Course(thematic: "science", courseOwner: "William Perez", creationDate: Timestamp.now(),
                      name: "Biología", institution: "IE Colegio Loyola", code: "williambiologia"),),
                  CourseCard(course: Course(thematic: "tech", courseOwner: "Anahí Salgado", creationDate: Timestamp.now(),
                      name: "Flutter Avanzado", institution: "Platzi", code: "anahiflutteravanzado"),),
                  CourseCard(course: Course(thematic: "society", courseOwner: "Freddy Vega", creationDate: Timestamp.now(),
                      name: "Startups", institution: "Platzi", code: "freddystartups"),),**/

                ],
              ),
            )
          ]
        )
      ],
    );
  }
}
