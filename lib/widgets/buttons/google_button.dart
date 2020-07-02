import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';

class GoogleButton extends StatelessWidget {

  AppBloc bloc;
  final String buttonText;

  final double topMargin;
  final double bottomMargin;

  GoogleButton({
    Key key,
    @required this.buttonText,
    @required this.topMargin,
    @required this.bottomMargin,
  });

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth*0.80;

    return Container(
      height: 50,
      width: buttonWidth,
      margin: EdgeInsets.only(
          top: topMargin,
          bottom: bottomMargin
      ),
      child: InkWell(
        onTap: (){

          bloc.user.signIn().then((FirebaseUser user){

            bloc.user.updateUserData(
                User(
                    uid: user.uid,
                    name: user.displayName,
                    email: user.email,
                    photoUrl: user.photoUrl,
                ));

          });

        },
        child: Container(
          height: 50.0,
          width: buttonWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12, width: 0.5),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(2, 2)
                )
              ]
          ),

          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/google.png")
                      )
                  ),
                ),
                Text(
                  buttonText,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Comfortaa",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),

                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}