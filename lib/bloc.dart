import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'Content/bloc/content_bloc.dart';
import 'Publication/bloc/publication_bloc.dart';
import 'User/bloc/user_bloc.dart';
import 'Course/bloc/course_bloc.dart';

class AppBloc implements Bloc {

  UserBloc user = UserBloc();
  CourseBloc course = CourseBloc();
  PublicationBloc publication = PublicationBloc();
  ContentBloc content = ContentBloc();

  @override
  void dispose() {
    // TODO: implement dispose
  }

}