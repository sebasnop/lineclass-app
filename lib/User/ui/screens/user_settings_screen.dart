import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/widgets/settings_header.dart';
import 'package:lineclass/bloc.dart';

// ignore: must_be_immutable
class UserSettingsScreen extends StatelessWidget {

  AppBloc bloc;

  final User user;

  UserSettingsScreen({Key key, this.user});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    bloc = BlocProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SettingsHeader(user: user,),
          Divider(),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              width: screenWidth-60,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow> [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(3, 3)
                  )
                ]
              ),
              alignment: Alignment.center,
              child: Text("Cerrar Sesión", style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Comfortaa"),),
            ),
            onTap: (){
              bloc.user.signOut();
            },
          )
        ],
      ),
    );
  }
}
