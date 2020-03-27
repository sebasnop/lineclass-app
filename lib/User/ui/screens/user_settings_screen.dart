import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/settings_header.dart';
import 'package:lineclass/widgets/own_app_bar.dart';

class UserSettingsScreen extends StatelessWidget {

  UserBloc userBloc;

  User user;

  UserSettingsScreen({Key key, this.user});

  @override
  Widget build(BuildContext context) {

    print(user.photoUrl);

    double screenWidth = MediaQuery.of(context).size.width;

    userBloc = BlocProvider.of(context);

    Widget profile = InkWell(
      child: Container(

        width: screenWidth,
        height: 80,
        color: Colors.teal,
        alignment: Alignment.center,
        child: Text("Cerrar Sesión", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Comfortaa"),),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          OwnAppBar(title: "Configuración"),
          SettingsHeader(user: user,),
          InkWell(
            child: Container(
              width: screenWidth,
              height: 80,
              color: Colors.teal,
              alignment: Alignment.center,
              child: Text("Cerrar Sesión", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Comfortaa"),),
            ),
            onTap: (){
              userBloc.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
