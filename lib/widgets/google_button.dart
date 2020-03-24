import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';

class GoogleButton extends StatefulWidget {

  final String buttonText;

  double topMargin;
  double bottomMargin;

  VoidCallback onTap;

  GoogleButton({
    Key key,
    @required this.buttonText,
    @required this.topMargin,
    @required this.bottomMargin,
    @required this.onTap,
  });

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {

    userBloc = BlocProvider.of(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth*0.80;

    return Container(
      height: 50,
      width: buttonWidth,
      margin: EdgeInsets.only(
          top: widget.topMargin,
          bottom: widget.bottomMargin
      ),
      child: InkWell(
        onTap: widget.onTap,
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