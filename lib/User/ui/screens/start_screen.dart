import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import"package:flutter/material.dart";
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/ui/screens/add_course_screen.dart';
import 'package:lineclass/Course/ui/screens/home_courses.dart';
import 'package:lineclass/Course/ui/widgets/search_course.dart';
import 'package:lineclass/Course/ui/widgets/your_courses.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/home_header.dart';
import 'package:lineclass/widgets/fab.dart';
import 'package:lineclass/widgets/google_button.dart';
import 'package:lineclass/widgets/green_button.dart';
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
          print("${snapshot.connectionState}");
          return home(userBloc, snapshot.connectionState, snapshot);
        } else if(snapshot.connectionState != ConnectionState.waiting) {
          return startUI(screenWidth, screenHeight);
        } else {
          return LoadingScreen(text: "Iniciando Sesión");
        }
      },
    );

  }

  Widget startUI(double screenWidth, double screenHeight) {

    double space1 = screenHeight*0.03;
    double space2 = screenHeight*0.02;
    double space3 = screenHeight*0.1;
    double space4 = screenHeight*0.019;
    double space5 = screenHeight*0.057;
    double space6 = screenHeight*0.05;

    Widget logoBox = Container(
      width: screenWidth*0.4,
      height: screenWidth*0.4,
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/logoa.png")
          )
      ),
    );

    Widget title = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: space2),
      child: Text(
        "Lineclass",
        style: TextStyle(
          fontFamily: "Comfortaa",
          fontSize: 48,
        ),
      ),
    );

    Widget subtitle = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: space3),
      child: Text(
        "¡Llega listo a clase!",
        style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
        ),
      ),
    );

    Widget already = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: space5, top: space5),
      child: Text(
        "¿Ya tienes una cuenta? ",
        style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 12,
        ),
      ),
    );

    Widget signIn = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: space5, top: space5),
      child: Text(
        "Inicia Sesión",
        style: TextStyle(
          color: Color(0xFF158A8C),
          fontFamily: "Comfortaa",
          fontSize: 12,
          fontWeight: FontWeight.bold
        ),
      ),
    );

    Widget version = Container (
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: space6),
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          logoBox,
          title,
          subtitle,
          GreenButton(bottomMargin: 0, topMargin: 0, buttonText: "Crear cuenta",),
          GoogleButton(bottomMargin: 0, topMargin: space4, buttonText: "Entra con Google"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              already,
              signIn
            ],
          ),
          version
        ],
      ),
    );

  }

  Widget home (UserBloc userBloc, ConnectionState guaco, AsyncSnapshot snapshot) {

      userBloc = BlocProvider.of(context);

      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;

        if(!snapshot.hasData || snapshot.hasError){

          return LoadingScreen(text: "Se ha presentado un error");

        } else {

          var user = User(
            uid: snapshot.data.uid,
            name: snapshot.data.displayName,
            email: snapshot.data.email,
            photoUrl: snapshot.data.photoUrl,
          );

          return StreamBuilder(
            stream: userBloc.getUser(user),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if(snapshot.hasData && !snapshot.hasError) {
                User usuario = userBloc.buildUser(snapshot.data);
                return HomeCourses(user: usuario);
              } else if(snapshot.connectionState != ConnectionState.waiting) {
                return startUI(screenWidth, screenHeight);
              } else {
                return LoadingScreen(text: "Iniciando Sesión");
              }
            },

          );

          /**userBloc.getUser(user);

          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                HomeHeader(user: user),
                SearchCourse(),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight - 224 - 50,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                      YourCourses(),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Fab(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddCourseScreen(user: user)
                ));
              },
              icon: Icons.add,
              iconSize: 50,
            ),
          );

          **/
        }

  }


}
