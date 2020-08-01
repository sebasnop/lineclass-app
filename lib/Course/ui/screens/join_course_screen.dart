import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/screens/joined_course_screen.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:lineclass/widgets/own_appbar.dart';
import 'package:toast/toast.dart';

class JoinCourseScreen extends StatefulWidget {

  /// This screen is for a User that wants to join to a Course
  /// The User enter a code of the Course

  final User user;

  JoinCourseScreen({@required this.user});

  @override
  _JoinCourseScreenState createState() => _JoinCourseScreenState();
}

class _JoinCourseScreenState extends State<JoinCourseScreen> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    AppBloc bloc = BlocProvider.of <AppBloc> (context);
    double screenWidth = MediaQuery.of(context).size.width;

    double padding = screenWidth*0.09;

    /// Title saying that User needs to enter the code
    Widget text = Container(
      margin: EdgeInsets.only(top: padding*0.5),
      child: Text(
        "El código del curso es...",
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 23,
          fontFamily: "Comfortaa",
        ),
      ),
    );

    /// Form for set the code field
    Widget form = Container(
      child: FormBuilder(
        key: _fbKey,
        child: Container(
          margin: EdgeInsets.only(
              top: padding
          ),
          padding: EdgeInsets.only(
            top: 20, bottom: 20, right: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[ BoxShadow(color: Colors.black12,blurRadius: 1, offset: Offset(0,0))],
            //border: Border.all(color: Colors.black12, width: 0.4)
          ),
          child: FormBuilderTextField(
            keyboardType: TextInputType.text,
            autofocus: true,
            attribute: "code",
            cursorColor: Color(0xFF666666),
            style: TextStyle(
                fontFamily: "Comfortaa"
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.vpn_key, color: Colors.black38,),
              alignLabelWithHint: true,
              hintText: " Escribe el código :D",
              helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
              errorBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
              errorStyle: TextStyle(
                  fontFamily: "Comfortaa",
                  color: Colors.black38
              ),
            ),
            validators: [
              FormBuilderValidators.required(errorText: "Escribe un código"),
            ],
          ),
        ),
      ),
    );

    /// Function for when the User submit the code
    Function submit = () async {

      /// Check the internet connection
      bool internetConexion = await DataConnectionChecker().hasConnection;

      if (internetConexion){

        if (_fbKey.currentState.saveAndValidate()) {

          /// Screen for advice User that his code is being validated
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => LoadingScreen(text: "VALIDANDO TU \n CÓDIGO...",)
          ));

          /// Get the code written by the User
          String codeInitial = _fbKey.currentState.value["code"];
          /// Set the code to lower case (To clean it)
          String codeToLowerCase = codeInitial.toLowerCase();
          /// Delete the spaces (" ") on the code (To clean it too)
          String code = codeToLowerCase.replaceAll(RegExp(r" "), "");

          /// Get the List of all the courses on the courses's collection in Firebase (like a snapshot)
          bloc.course.allCourses().then(
            (snapshot){

              /// Get the List of all the courses that have the same code
              List <Course> repeatedCourses = bloc.course.repeatedListCourses(snapshot, code);

              /// If there is not a course with the same code...
              if (repeatedCourses.isEmpty) {

                /// Screen for advice to the user that the course does no exists
                Navigator.pop(context);
                Toast.show("Curso inexistente :(\n  Verifica tu código", context,
                    duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);

                /// If there is a course with the same code...
              } else {

                /// Get the User reference
                DocumentReference userReference = bloc.user.getUserReference(widget.user.uid);
                Course course = repeatedCourses[0];

                /// Get the ID of the User that owns the Course
                String courseOwnerUid = course.courseOwner.documentID;
                /// Get the ID of the User
                String userUid = userReference.documentID;

                /// Initialize a bool for validating that the user is not added yet to the Course
                bool studentAlreadyAdded = false;

                /// Validate if the User is already added to the course
                /// Serching if the User ID is the same than one of the members ID's
                course.members.forEach(
                        (member){
                      if (member.documentID == userUid) {
                        studentAlreadyAdded = true;
                      }
                    }
                );

                /// If the User owns the course OR is already added to the course...
                if (courseOwnerUid == userUid || studentAlreadyAdded){

                  /// Go back and advice it to the User
                  Navigator.pop(context);
                  Toast.show("Ya estás dentro del curso :D", context,
                      duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);

                  /// If the User is new, we add the User to the course...
                } else {

                  /// Initialize a list of current members
                  List <DocumentReference> currentMembers;
                  currentMembers = course.members;

                  /// Add the User to the list of current members
                  currentMembers.add(userReference);

                  /// Update the list of current members
                  course.members = currentMembers;
                  bloc.course.updateCourseMembers(course);

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      JoinedCourseScreen(course: course)), (Route<dynamic> route) => false);

                  Toast.show("¡Curso Añadido con éxito!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                }
              }
            }
          );

        } else {
          Toast.show("Completa los campos requeridos", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
        }

      } else if (!internetConexion){
        Toast.show("Verifica tu conexión a internet :(", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
      }

    };

    void _exit (){
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: OwnAppbar(title: "Ingresar a Curso", actionName: "Entrar", backFunction: _exit,
          actionFunction: submit, ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(padding),
        children: <Widget>[
          text,
          form
        ],
      ),
    );
  }
}
