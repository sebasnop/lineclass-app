import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/screens/copycode_course_screen.dart';
import 'package:lineclass/Course/ui/widgets/thematic_course_option.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/widgets/blue_button.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:lineclass/widgets/own_back_button.dart';
import 'package:toast/toast.dart';

class CreateCourseScreen extends StatefulWidget {

  User user;

  CreateCourseScreen({Key key, @required this.user});

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();

}

class _CreateCourseScreenState extends State<CreateCourseScreen> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    UserBloc userBloc = BlocProvider.of <UserBloc> (context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                    bottom: paddingField*0.8
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
                    suffixIcon: Icon(Icons.beenhere),
                      alignLabelWithHint: true,
                      hintText: "",
                      labelText: "Nombre",
                      helperText: "2 a 28 dígitos",
                      helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
                      labelStyle: TextStyle(color:Colors.black38),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.black38)),
                      errorStyle: TextStyle(
                          fontFamily: "Comfortaa"
                      ),
                      contentPadding: EdgeInsets.only(
                        left: paddingField/2,
                        right: paddingField/2
                    )
                  ),
                  validators: [
                    FormBuilderValidators.required(errorText: "Escribe un nombre"),
                    FormBuilderValidators.minLength(2, errorText: "Debe contener más letras"),
                    FormBuilderValidators.maxLength(28, errorText: "Debe contener menos letras"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: paddingField,
                    right: paddingField,
                    bottom: paddingField*0.8
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[ BoxShadow(color: Colors.black12,blurRadius: 2)]
                ),
                child: FormBuilderTextField(
                  attribute: "institution",
                  cursorColor: Color(0xff686868),
                  style: TextStyle(
                      fontFamily: "Comfortaa"
                  ),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.location_on),
                      hintText: "",
                      labelText: "Institución Educativa",
                      helperText: "2 a 50 dígitos",
                      helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
                      labelStyle: TextStyle(color:Colors.black38),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.black38)),
                      errorStyle: TextStyle(
                          fontFamily: "Comfortaa"
                      ),
                      contentPadding: EdgeInsets.only(
                          left: paddingField/2,
                          right: paddingField/2
                      )
                  ),
                  validators: [
                    FormBuilderValidators.maxLength(50),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: paddingField,
                    right: paddingField,
                    bottom: paddingField*1
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[ BoxShadow(color: Colors.black12,blurRadius: 2)]
                ),
                child: FormBuilderDropdown(
                  attribute: "thematic",
                  style: TextStyle(
                      fontFamily: "Comfortaa"
                  ),
                  initialValue: "Temática del curso",
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontFamily: "Comfortaa"
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.white)),
                      contentPadding: EdgeInsets.only(
                          left: paddingField/2,
                          right: paddingField/2
                      )
                  ),
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                        value: "Temática del curso",
                        child: Text("Temática del curso", style: TextStyle(color: Colors.black38, fontFamily: "Comfortaa",fontSize: 17),)
                    ),
                    DropdownMenuItem(
                      value: "math",
                      child: ThematicCourseOption(text: "Matemáticas", icon: Icons.equalizer,)
                    ),
                    DropdownMenuItem(
                      value: "science",
                      child: ThematicCourseOption(text: "Ciencia", icon: Icons.filter_hdr,)
                    ),
                    DropdownMenuItem(
                      value: "tech",
                      child: ThematicCourseOption(text: "Tecnología", icon: Icons.devices,)
                    ),
                    DropdownMenuItem(
                      value: "languages",
                      child: ThematicCourseOption(text: "Lenguaje", icon: Icons.forum,)
                    ),
                    DropdownMenuItem(
                      value: "sports",
                      child: ThematicCourseOption(text: "Deportes", icon: Icons.directions_run,)
                    ),
                    DropdownMenuItem(
                        value: "society",
                        child: ThematicCourseOption(text: "Sociedad", icon: Icons.account_balance,)
                    ),
                    DropdownMenuItem(
                        value: "art",
                        child: ThematicCourseOption(text: "Arte", icon: Icons.color_lens,)
                    ),
                    DropdownMenuItem(
                        value: "other",
                        child: ThematicCourseOption(text: "Otro", icon: Icons.all_inclusive,)
                    ),
                  ],
                  validators: [
                    FormBuilderValidators.required(errorText: ""),
                    FormBuilderValidators.maxLength(15, errorText: "Escoge una temática")
                  ],
                ),
              ),
              Container(
                child: BlueButton(
                  bottomMargin: 50,
                  topMargin: screenHeight*0.08,
                  buttonText: "¡ Crear !",
                  onPressed: () async {

                    bool internetConexion = await DataConnectionChecker().hasConnection;

                    if (internetConexion){

                      if (_fbKey.currentState.saveAndValidate()) {

                        //int now = DateTime.now().microsecond;
                        String courseNameInitial = _fbKey.currentState.value["name"];
                        String courseInstitution = _fbKey.currentState.value["institution"] ?? "";

                        String courseThematicInitial = _fbKey.currentState.value["thematic"];

                        String courseThematic = courseThematicInitial.trim();

                        String courseName = courseNameInitial.trim();

                        String courseNameLower = courseName.toLowerCase();

                        String courseA = courseNameLower.replaceAll(RegExp(r"á"), "a");
                        String courseE = courseA.replaceAll(RegExp(r"é"), "e");
                        String courseI = courseE.replaceAll(RegExp(r"í"), "i");
                        String courseO = courseI.replaceAll(RegExp(r"ó"), "o");
                        String courseU = courseO.replaceAll(RegExp(r"ú"), "u");

                        String courseNameNoSpaces = courseU.replaceAll(RegExp(r" "), "");

                        String code = "$courseNameNoSpaces";

                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => LoadingScreen(text: "AÑADIENDO TU \n CURSO...",)
                        ));

                        userBloc.allCourses().then(
                                (snapshot){

                                  List <Course> repeatedCourses = List <Course> ();
                                  snapshot.forEach((f){

                                    if (f.data["code"] == code){
                                      Course course = Course (code: f.data["code"],creationDate: DateTime.now(),
                                          thematic: f.data["thematic"],name: f.data["name"], institution: f.data["institution"], courseOwner: f.data["userOwner"]);
                                      repeatedCourses.add(course);

                                    }

                                  });

                                  if (repeatedCourses.isNotEmpty) {

                                    Navigator.pop(context);
                                    Toast.show("Curso repetido :( \n Prueba con otro nombre o identificador", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);

                                  } else {
                                    print ("Curso no repetido");
                                    print(repeatedCourses.length);

                                    userBloc.updateCourseData(Course(
                                      name: courseName,
                                      institution: courseInstitution,
                                      code: code,
                                      thematic: courseThematic,
                                      creationDate: DateTime.now(),
                                      courseOwner: widget.user.name
                                    )).whenComplete( () {

                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                          CopycodeCourseScreen(code: code)), (Route<dynamic> route) => false);

                                      Toast.show("¡Curso Creado con éxito!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                                    });

                                  }

                                });


                        //print(_fbKey.currentState.value);
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
