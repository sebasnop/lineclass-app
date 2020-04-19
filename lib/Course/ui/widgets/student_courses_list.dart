import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class StudentCoursesList extends StatelessWidget {

  final User user;

  StudentCoursesList ({Key key, this.user});

  @override
  Widget build(BuildContext context) {

    AppBloc bloc = BlocProvider.of<AppBloc>(context);

    DocumentReference userReference = bloc.user.getUserReference(user.uid);

    return Container(
      child: StreamBuilder(
          stream: bloc.course.coursesListStream(userReference),
          builder: (context, AsyncSnapshot snapshot){

            //0 is new_a, 1 is new_b, 2 is notNew,
            int role = 1;

            QuerySnapshot student;
            QuerySnapshot teacher;

            if (snapshot.data != null) {

              List<QuerySnapshot> querySnapshotData =  snapshot.data.toList();

              student = querySnapshotData[0];
              teacher = querySnapshotData[1];

              int studentCourses= student.documents.length;
              int teacherCourses= teacher.documents.length;

              if(teacherCourses > 0 || studentCourses > 0){
                role = 2;
              }

            }

            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return OwnCircularProgress(height: 100, width: 100);
              case ConnectionState.done:
                if (snapshot.data != null) {
                  return Column(
                      children: bloc.course.buildCourses(
                          student.documents, user, role)
                  );
                } else {
                  return OwnCircularProgress(height: 100, width: 100);
                }
                break;
              case ConnectionState.active:
                if (snapshot.data != null) {
                  return Column(
                      children: bloc.course.buildCourses(
                          student.documents, user, role)
                  );
                } else {
                  return OwnCircularProgress(height: 100, width: 100);
                }
                break;

              case ConnectionState.none:

                List <String> noCourseMessages = ["No se pudo cargar :(", "Inténtalo más tarde", "error"];

                CourseCard courseCard = CourseCard(
                  noCourseMessages: noCourseMessages,
                );

                return Column (
                  children: <Widget>[
                      courseCard
                    ],
                );
              default:
                return OwnCircularProgress(height: 100, width: 100);
            }

          }

      ),
    );
  }


}
