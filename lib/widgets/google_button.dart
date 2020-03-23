import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';

class GoogleButton extends StatefulWidget {

  final String buttonText;

  double topMargin;
  double bottomMargin;

  GoogleButton({
    Key key,
    @required this.buttonText,
    @required this.topMargin,
    @required this.bottomMargin,
  });

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonWidth = screenWidth*0.85;

    UserBloc userBloc;

    return Container(
      height: 50,
      width: buttonWidth,
      margin: EdgeInsets.only(
          top: widget.topMargin,
          bottom: widget.bottomMargin
      ),
      child: InkWell(
        onTap: (){

          /**userBloc.signIn().then((FirebaseUser user){

            userBloc.updateUserData(
                User(
                id: user.uid,
                name: user.displayName,
                email: user.email,
                photoUrl: user.photoUrl,
                firstName: user.displayName
            ));

          });**/

        },
        child: Container(
          height: 50.0,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white
          ),

          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.black,
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(right: 20),
                ),
                Text(
                  widget.buttonText,
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


