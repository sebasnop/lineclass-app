import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/ui/screens/start_screen.dart';
import 'bloc.dart';


Future main() async {

  /// Set the Device Orientation to Portrait Up.
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Set the Notifications Bar Style while app is running
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

    /// Use BLoC Architecture in the project
    return BlocProvider(
      bloc: AppBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF1E56A0),
          accentColor: Colors.white,
        ),
        title: 'Lineclass',
        home: StartScreen(),
      ),
    );
  }
}

