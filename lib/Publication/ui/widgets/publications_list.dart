import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class PublicationsList extends StatelessWidget {

  final Course course;
  final User user;

  const PublicationsList({Key key, @required this.course, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    DocumentReference courseReference = bloc.course.getCourseReference(course.id);

    return Container(
      child: StreamBuilder(
          stream: bloc.publication.publicationsListStream(courseReference),
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return OwnCircularProgress(height: 100, width: 100);
              case ConnectionState.done:
                return Column(
                    children: bloc.publication.buildPublications(snapshot.data.documents, user)
                );
              case ConnectionState.active:
                return Column(
                    children: bloc.publication.buildPublications(snapshot.data.documents, user)
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
