import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lineclass/widgets/own_back_button.dart';

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();

}

class _CreateCourseScreenState extends State<CreateCourseScreen> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double backButtonWidth = screenWidth*0.20;

    double paddingField = screenWidth*0.10;

    Widget createCourseText = Container(
      margin: EdgeInsets.only(top: 30, bottom:45),
      child: Center(
        child: Text(
          "Crear Curso",
          style: TextStyle(
              fontSize: 30,
              color: Color(0xff686868),
              fontFamily: "Comfortaa"
          ),
        ),
      ),
    );

    Widget form = Column(
      children: <Widget>[
        FormBuilder(
          key: _fbKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: paddingField,
                    right: paddingField,
                    bottom: paddingField*1.25
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[ BoxShadow(color: Colors.black12,blurRadius: 2)]
                ),
                child: FormBuilderTextField(
                  attribute: "name",
                  cursorColor: Color(0xff686868),
                  style: TextStyle(
                    fontFamily: "Comfortaa"
                  ),
                  decoration: InputDecoration(
                      labelText: "Nombre",
                      errorStyle: TextStyle(
                          fontFamily: "Comfortaa"
                      ),
                      contentPadding: EdgeInsets.only(
                        left: paddingField/2,
                        right: paddingField/2
                    )
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(2),
                    FormBuilderValidators.maxLength(28),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: paddingField,
                    right: paddingField
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[ BoxShadow(color: Colors.black12,blurRadius: 2)]
                ),
                child: FormBuilderTextField(
                  attribute: "indicator",
                  cursorColor: Color(0xff686868),
                  style: TextStyle(
                      fontFamily: "Comfortaa"
                  ),
                  decoration: InputDecoration(
                      labelText: "Indicador Numérico",
                      errorStyle: TextStyle(
                          fontFamily: "Comfortaa"
                      ),
                      contentPadding: EdgeInsets.only(
                          left: paddingField/2,
                          right: paddingField/2
                      )
                  ),
                  validators: [
                    FormBuilderValidators.numeric(),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          OwnBackButton(width: backButtonWidth, height: backButtonWidth, backText: "Volver"),
          createCourseText,
          form
        ],
      ),
    );
  }
}
