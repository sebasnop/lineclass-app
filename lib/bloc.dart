import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'Publication/bloc/publication_bloc.dart';
import 'User/bloc/user_bloc.dart';
import 'Course/bloc/course_bloc.dart';

class AppBloc implements Bloc {

  UserBloc user = UserBloc();
  CourseBloc course = CourseBloc();
  PublicationBloc publication = PublicationBloc();

  @override
  void dispose() {
    // TODO: implement dispose
  }

}