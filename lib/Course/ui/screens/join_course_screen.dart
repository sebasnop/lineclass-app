import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/widgets/blue_button.dart';
import 'package:lineclass/widgets/fab.dart';
import 'package:lineclass/widgets/own_back_button.dart';
import 'package:toast/toast.dart';

class JoinCourseScreen extends StatefulWidget {

  User user;

  JoinCourseScreen({@required this.user});

  @override
  _JoinCourseScreenState createState() => _JoinCourseScreenState();
}

class _JoinCourseScreenState extends State<JoinCourseScreen> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    UserBloc userBloc = BlocProvider.of <UserBloc> (context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double backButtonWidth = screenWidth*0.2;

    double paddingField = screenWidth*0.09;

    Widget text = Container(
      margin: EdgeInsets.only(top: screenHeight*0.2),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: paddingField, right: paddingField),
      child: Text(
        "El código del curso es",
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 40,
          fontFamily: "Comfortaa",
        ),
      ),
    );

    Widget form = Container(
      child: FormBuilder(
          key: _fbKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: paddingField,
                    right: paddingField,
                    bottom: paddingField*1,
                    top: paddingField*5
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[ BoxShadow(color: Colors.black12,blurRadius: 2)],
                  border: Border.all(color: Colors.black54, width: 0.4)
                ),
                child: FormBuilderTextField(
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  attribute: "code",
                  cursorColor: Color(0xff686868),
                  style: TextStyle(
                      fontFamily: "Comfortaa"
                  ),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.code),
                      alignLabelWithHint: true,
                      hintText: "",
                      labelText: "Ingresa el código : )",
                      helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
                      labelStyle: TextStyle(color:Colors.black38),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
                      errorStyle: TextStyle(
                          fontFamily: "Comfortaa"
                      ),
                      contentPadding: EdgeInsets.only(
                          left: paddingField/2,
                          right: paddingField/2
                      )
                  ),
                  validators: [
                    FormBuilderValidators.required(errorText: "Escribe un código"),
                  ],
                ),
              ),
              BlueButton(
                buttonText: "¡Entrar!",
                topMargin: 0,
                bottomMargin: 0,
                onPressed: () async {

                  bool internetConexion = await DataConnectionChecker().hasConnection;

                  if (internetConexion){

                    print("Hay internet");

                  } else if (!internetConexion){
                    Toast.show("Verifica tu conexión a internet :)", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                  }

                }
                )
            ],
          ),
        )
    );

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(bottom:40),
        children: <Widget>[
          OwnBackButton(width: backButtonWidth, height: backButtonWidth, backText: "Volver"),
          text,
          form
        ],
      ),
    );
  }
}
