import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/ui/widgets/blue_button.dart';
import 'package:lineclass/widgets/own_back_button.dart';
import 'package:toast/toast.dart';

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();

}

class _CreateCourseScreenState extends State<CreateCourseScreen> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    UserBloc userBloc = BlocProvider.of <UserBloc> (context);

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
                  attribute: "identifier",
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
                    FormBuilderValidators.required(),
                  ],
                ),
              ),
              Container(
                child: BlueButton(
                  buttonText: "¡ Crear !",
                  onPressed: () async {

                    bool internetConexion = await DataConnectionChecker().hasConnection;

                    if (internetConexion){

                      if (_fbKey.currentState.saveAndValidate()) {

                        String courseName = _fbKey.currentState.value["name"];
                        String courseIdentifier = _fbKey.currentState.value["identifier"];

                        userBloc.updateCourseData(Course(
                          name: "Química",
                          identifier: 2,
                          creationDate: DateTime.now()
                        ));

                        print(_fbKey.currentState.value);
                      } else {
                        Toast.show("Completa los campos requeridos", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
                      }

                    } else if (!internetConexion){
                      Toast.show("Verifica tu conexión a internet :)", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                    }

                  },
                ),
              )
            ],
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          OwnBackButton(width: backButtonWidth, height: backButtonWidth, backText: "Volver"),
          createCourseText,
          form
        ],
      ),
    );
  }
}
