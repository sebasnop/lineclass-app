import 'package:cloud_firestore/cloud_firestore.dart';
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
    double backButtonWidth = screenWidth*0.2;

    double paddingField = screenWidth*0.1;

    Widget createCourseText = Container(
      width: screenWidth,
      height: screenHeight*0.2,
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
                    bottom: paddingField*1,
                    top: paddingField*0.6
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[ BoxShadow(color: Colors.black12,blurRadius: 2)]
                ),
                child: FormBuilderTextField(
                  autofocus: true,
                  /**onEditingComplete: (){

                  },**/
                  attribute: "name",
                  //keyboardType: TextInputType.text,
                  cursorColor: Color(0xff686868),
                  style: TextStyle(
                    fontFamily: "Comfortaa"
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.beenhere),
                      alignLabelWithHint: true,
                      hintText: "",
                      labelText: "Nombre",
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
                    bottom: paddingField*1
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
                      alignLabelWithHint: true,
                      hintText: "",
                      labelText: "Institución Educativa",
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
                    FormBuilderValidators.maxLength(50),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: paddingField,
                    right: paddingField,
                    bottom: paddingField*0.7
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
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
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
                        value: "music",
                        child: ThematicCourseOption(text: "Música", icon: Icons.audiotrack,)
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
                  bottomMargin: screenHeight*0.02,
                  topMargin: screenHeight*0.1,
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

                        String courseOwnerNickname = widget.user.nickname;

                        String code = "$courseNameNoSpaces$courseOwnerNickname";

                        Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => LoadingScreen(text: "AÑADIENDO TU \n CURSO...",)
                        ));

                        userBloc.allCourses().then(
                                (snapshot){

                                  List <Course> repeatedCourses = userBloc.repeatedListCourses(snapshot, code);

                                  if (repeatedCourses.isNotEmpty) {

                                    Navigator.pop(context);
                                    Toast.show("       Curso repetido :( \nPrueba con otro nombre", context,
                                        duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);

                                  } else {

                                    List <String> guaco = [];

                                    userBloc.createCourse(Course(
                                      id: "",
                                      name: courseName,
                                      institution: courseInstitution,
                                      code: code,
                                      thematic: courseThematic,
                                      creationDate: Timestamp.now(),
                                      courseOwner: widget.user,
                                      members: guaco
                                    )).whenComplete( () {

                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                          CopycodeCourseScreen(code: code)), (Route<dynamic> route) => false);

                                      Toast.show("¡Curso Creado con éxito!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                                    });

                                  }

                                });

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

    Widget finalForm = SizedBox (
      height: screenHeight*0.7,
      width: screenWidth,
      child: form,
    );

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top:0, bottom: 0),
        children: <Widget>[
          OwnBackButton(width: backButtonWidth, height: backButtonWidth, backText: "Volver"),
          createCourseText,
          finalForm
        ],
      ),
    );
  }
}
