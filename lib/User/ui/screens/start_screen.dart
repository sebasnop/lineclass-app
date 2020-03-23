import 'package:flutter/cupertino.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return _handleCurrentSession (screenWidth, screenHeight);
  }

  Widget _handleCurrentSession(double screenWidth, double screenHeight){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasData && !snapshot.hasError) {
          return HomeCourses();
        } else if(snapshot.connectionState != ConnectionState.waiting) {
          return startUI(screenWidth, screenHeight);
        } else {
          return LoadingScreen(text: "Iniciando Sesión");
        }
      },
    );

  }

  Widget startUI(double screenWidth, double screenHeight) {

    Widget logoBox = Container(
      width: screenWidth*0.33,
      height: screenWidth*0.33,
      margin: EdgeInsets.only(top: screenHeight*0.13, bottom: 30),
      color: Colors.black,
    );

    Widget title = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        "Lineclass",
        style: TextStyle(
          fontFamily: "Comfortaa",
          fontSize: 48
        ),
      ),
    );

    Widget subtitle = Container (
      alignment: Alignment.center,
      child: Text(
        "¡Llega listo a clase!",
        style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20
        ),
      ),
    );

    Widget already = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 42, top:42),
      child: Text(
        "¿Ya tienes una cuenta? Inicia Sesión",
        style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 12,
        ),
      ),
    );

    Widget version = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 35),
      child: Text(
        "Versión 1.0",
        style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 13,
        color: Color(0xFFD1D1D1)
        ),
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          logoBox,
          title,
          subtitle,
          already,
          version
        ],
      ),
    );

  }


}
