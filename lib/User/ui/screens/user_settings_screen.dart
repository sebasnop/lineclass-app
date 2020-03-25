import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/widgets/own_app_bar.dart';

class UserSettingsScreen extends StatelessWidget {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    userBloc = BlocProvider.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          OwnAppBar(title: "Configuración"),
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
