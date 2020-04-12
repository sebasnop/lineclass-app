import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/ui/screens/start_screen.dart';
import 'bloc.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
      )
  );

  runApp(MyApp());

}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      bloc: AppBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        title: 'Lineclass',
        home: StartScreen(),
      ),
    );
  }
}

