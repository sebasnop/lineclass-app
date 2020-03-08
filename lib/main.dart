import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/ui/screens/home_courses.dart';

import 'User/bloc/user_bloc.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      bloc: UserBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        title: 'Lineclass',
        initialRoute: "/",
        routes: {
          "/": (context) => HomeCourses()
        },
      ),
    );
  }
}

