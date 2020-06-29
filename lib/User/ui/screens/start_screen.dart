import 'package:flutter/cupertino.dart';
import"package:flutter/material.dart";
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/screens/navigation_drawer.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/google_button.dart';
import 'package:lineclass/widgets/green_button.dart';
import 'package:lineclass/widgets/loading_screen.dart';

/// Create an stateful because maybe in the future it could be util for IntroScreen
class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  /// Instantiate the global bloc to call methods
  AppBloc bloc;

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of(context);

    /// Get the current device's width & height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    /// This handle allow us to control what to show knowing if user is logged in or not
    return _handleCurrentSession (screenWidth, screenHeight);
  }

  Widget _handleCurrentSession(double screenWidth, double screenHeight){

    /// This StreamBuilder is handled by the state of the Firebase Auth Status stream
    return StreamBuilder(
      stream: bloc.user.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasData && !snapshot.hasError) {
          return home(bloc, snapshot.connectionState, snapshot);
        } else if(snapshot.connectionState != ConnectionState.waiting) {
          return startUI(screenWidth, screenHeight);
        } else {
          return LoadingScreen(text: "Iniciando Sesión");
        }
      },
    );

  }

  /// Define the Log In screen for not logged in users
  Widget startUI(double screenWidth, double screenHeight) {

    ///This Log In screen have:
      /// Logo
      /// App Name
      /// App Slogan
      /// Create Account Button
      /// Google Log In Button
      /// Already have an Account? Log In Button Text
      /// App Version

    /// Define spaces between the widgets of the Log In screen for avoid screen size issues
    double space1 = screenHeight*0.037;
    double space2 = screenHeight*0.02;
    double space3 = screenHeight*0.1;
    double space4 = screenHeight*0.019;
    double space5 = screenHeight*0.057;
    double space6 = screenHeight*0.05;

    Widget logoBox = Container(
      width: screenWidth*0.4,
      height: screenWidth*0.4,
      margin: EdgeInsets.only(bottom: space1),
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/logoa.png")
          )
      ),
    );

    Widget appName = Container (
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

    Widget appSlogan = Container (
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
          appName,
          appSlogan,
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

  /// Create a StreamBuilder that allows us to make sure that we have the user's information
  Widget home (AppBloc bloc, ConnectionState connectionState, AsyncSnapshot snapshot) {

      bloc = BlocProvider.of(context);

      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;

        if(!snapshot.hasData || snapshot.hasError){

          return LoadingScreen(text: "Se ha presentado un error");

        } else {

          /// Instantiate User, only for know the User Uid
          // ignore: missing_required_param
          User basicUser = User(
            uid: snapshot.data.uid,
          );

          /// Method getUser use the User Uid obtained with Firebase Auth, to gets a DocumentSnapshot from Firebase FireStore
          return StreamBuilder(
            stream: bloc.user.getUser(basicUser.uid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if(snapshot.hasData && !snapshot.hasError) {

                /// Then, we use that DocumentSnapshot on buildUser method,
                /// building a completely User object using FireStore Saved Attributes
                User user = bloc.user.buildUser(snapshot.data);

                /// And send it to the NavigationDrawer, that controls what screen is displayed
                return NavigationDrawer(user: user);

              } else if(snapshot.connectionState != ConnectionState.waiting) {
                return startUI(screenWidth, screenHeight);
              } else {
                return LoadingScreen(text: "Iniciando Sesión");
              }
            },

          );

        }

  }


}
