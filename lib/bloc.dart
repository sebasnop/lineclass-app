import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'Content/bloc/content_bloc.dart';
import 'Publication/bloc/publication_bloc.dart';
import 'User/bloc/user_bloc.dart';
import 'Course/bloc/course_bloc.dart';

class AppBloc implements Bloc {

  /// Using Bloc & Clean Architecture, setting Entities and separating their functions.

  /// It's an educational app, and currently for this, it has:
      /// Users that creates Courses (Teachers) or joins to created Courses (Students).
      /// Courses, which are spaces for Users (Who own the course or have joined) to create and share Publications.
      /// Publications that contains Contents, added by Users while they are creating a Publication.

  UserBloc user = UserBloc();
  CourseBloc course = CourseBloc();
  PublicationBloc publication = PublicationBloc();
  ContentBloc content = ContentBloc();

  @override
  void dispose() {
    // TODO: implement dispose
  }

}