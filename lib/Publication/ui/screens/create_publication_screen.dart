import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/screens/course_screen.dart';
import 'package:lineclass/Course/ui/screens/home_courses.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:toast/toast.dart';

class CreatePublicationScreen extends StatefulWidget {

  final User user;
  final Course course;

  CreatePublicationScreen({Key key, @required this.user, @required this.course});

  @override
  _CreatePublicationScreenState createState() => _CreatePublicationScreenState();
}

class _CreatePublicationScreenState extends State<CreatePublicationScreen> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    AppBloc bloc = BlocProvider.of <AppBloc> (context);

    Container titleInput = Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
          top: 20
      ),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12,width: 0.3))
      ),
      child: FormBuilderTextField(
        autofocus: true,
        attribute: "title",
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Color(0xff686868),
        style: TextStyle(
          //fontFamily: "Comfortaa",
          fontSize: 20,
          //letterSpacing: 0.3,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: "Escribe un título breve",
            //labelText: "Título",
            helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
            labelStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa"),
            hintStyle: TextStyle(color: Colors.black38, fontFamily: "Comfortaa"),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            errorStyle: TextStyle(
                fontFamily: "Comfortaa",
                color: Colors.black26
            ),
            contentPadding: EdgeInsets.only(
                left: 10,
                right: 10
            )
        ),
        validators: [
          FormBuilderValidators.required(errorText: "Escribe un título"),
          FormBuilderValidators.minLength(2, errorText: "Debe contener más letras"),
          FormBuilderValidators.maxLength(35, errorText: "Debe contener menos letras"),
        ],
      ),
    );

    Container descriptionInput = Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
          top: 0
      ),
      padding: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12,width: 0.2))
      ),
      child: FormBuilderTextField(
        attribute: "description",
        keyboardType: TextInputType.multiline,
        cursorColor: Color(0xff979797),
        style: TextStyle(
          //fontFamily: "Comfortaa",
          fontSize: 16,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: "Escribe una descripción...",
            labelStyle: TextStyle(color:Colors.black12, /**fontFamily: "Comfortaa"**/),
            hintStyle: TextStyle(color: Colors.black26, /**fontFamily: "Comfortaa"**/),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            errorStyle: TextStyle(
                fontFamily: "Comfortaa",
                color: Colors.black26
            ),
            contentPadding: EdgeInsets.only(
                left: 10,
                right: 10
            )
        ),
        validators: [
          FormBuilderValidators.maxLength(200, errorText: "Debe contener menos letras"),
        ],
      ),
    );

    Container form = Container(
      child: FormBuilder(
        key: _fbKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            titleInput,
            descriptionInput
          ],
        )
      )
    );

    Future <void> Function () submit = () async {

      bool internetConexion = await DataConnectionChecker().hasConnection;

      if (internetConexion) {

        if (_fbKey.currentState.saveAndValidate()) {

          String title = _fbKey.currentState.value["title"];
          String description = _fbKey.currentState.value["description"] ?? "";

          DocumentReference userReference = bloc.user.getUserReference(widget.user.uid);
          DocumentReference courseReference = bloc.course.getCourseReference(widget.course.id);

          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => LoadingScreen(text: "PUBLICANDO...",)
          ));

          Timestamp publicationDate = Timestamp.now();

          Publication publication = Publication(
            id: "",
            title: title,
            description: description,
            course: courseReference,
            publisher: userReference,
            publicationDate: publicationDate
          );

          bloc.publication.createPublication(publication).whenComplete( () {

            Navigator.pop(context);
            Navigator.pop(context);

            Toast.show("¡Publicación hecha!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

          });;

        } else {
          Toast.show("Completa los campos requeridos", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
        }

      } else if (!internetConexion){
        Toast.show("Verifica tu conexión a internet :)", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
      }

    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFf6f6f6),
        elevation: 2,
        title: Text("Agregar Contenido", style: TextStyle(fontFamily: "Comfortaa", fontSize: 16, color: Colors.black,)),
        leading: InkWell(
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  "Publicar",
                  style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontSize: 16,
                      color: Color(0xFF1E56A0),
                      fontWeight: FontWeight.bold
                  ),
                ),
            ),
            onTap: submit,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          form
        ],
      )
    );
  }
}

