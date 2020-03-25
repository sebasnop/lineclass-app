import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/ui/screens/add_course_screen.dart';
import 'package:lineclass/Course/ui/widgets/search_course.dart';
import 'package:lineclass/Course/ui/widgets/your_courses.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/home_header.dart';
import 'package:lineclass/User/ui/widgets/user_welcome.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:lineclass/widgets/own_app_bar.dart';
import 'package:lineclass/widgets/fab.dart';
import 'package:lineclass/widgets/own_circular_progress.dart';

class HomeCourses extends StatelessWidget {

  double appBarHeight = 80; //Medida de altura de Material Design

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget showProfileData (AsyncSnapshot snapshot) {

      if(!snapshot.hasData || snapshot.hasError){

        return LoadingScreen(text: "Se ha presentado un error");

      } else {

        var user = User(
            id: snapshot.data.uid,
            name: snapshot.data.displayName,
            email: snapshot.data.email,
            photoUrl: snapshot.data.photoUrl,
        );

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
      }

    }


    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            return LoadingScreen(text: "Cargando tus cursos3");
          case ConnectionState.none:
            return LoadingScreen(text: "Cargando tus cursos1");

          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);

          default:
            return LoadingScreen(text: "Cargando tus cursos");
        }
      },
    );



  }



}
