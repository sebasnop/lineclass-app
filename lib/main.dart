import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lineclass/Course/ui/home_courses.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff36C186),
      ),
      title: 'Lineclass',
      home: HomeCourses(),
    );
  }
}

