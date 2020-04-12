import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class YourCoursesList extends StatelessWidget {

  final User user;

  YourCoursesList ({Key key, this.user});

  @override
  Widget build(BuildContext context) {

    AppBloc bloc = BlocProvider.of<AppBloc>(context);

    DocumentReference userReference = bloc.user.getUserReference(user.uid);

    return Container(
      child: StreamBuilder(
          stream: bloc.course.yourCoursesListStream(userReference),
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return OwnCircularProgress(height: 100, width: 100);
              case ConnectionState.done:
                return Column(
                    children: bloc.course.buildCourses(snapshot.data.documents, user)
                );
              case ConnectionState.active:
                return Column(
                    children: bloc.course.buildCourses(snapshot.data.documents, user)
                );

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
