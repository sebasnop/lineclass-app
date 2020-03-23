import"package:flutter/material.dart";
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/ui/screens/home_courses.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/widgets/loading_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of(context);
    double screenWidht = MediaQuery.of(context).size.width;

    return _handleCurrentSession ();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasData && !snapshot.hasError) {
          return HomeCourses();
        } else if(snapshot.connectionState != ConnectionState.waiting) {
          return startUI();
        } else {
          return LoadingScreen(text: "Iniciando Sesión");
        }
      },
    );

  }

  Widget startUI() {

    Widget logoBox = Container(
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

        ],
      ),
    );

  }


}
