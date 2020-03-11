import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class YourCoursesList extends StatelessWidget {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      child: StreamBuilder(
          stream: userBloc.coursesListStream,
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return OwnCircularProgress(height: 100, width: 100);
              case ConnectionState.done:
                return Column(
                    children: userBloc.buildCourses(snapshot.data.documents)
                );
              case ConnectionState.active:
                return Column(
                    children: userBloc.buildCourses(snapshot.data.documents)
                );

              case ConnectionState.none:
                return Column (
                  children: <Widget>[
                    CourseCard(course: Course(thematic: "error", courseOwner: "Verifica tu conexión a internet", creationDate: Timestamp.now(),
                        name: "No se pudo conectar :(", institution: "", code: "", id: "", members: List <String> ()) ),
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
