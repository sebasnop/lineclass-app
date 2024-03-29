import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/ui/screens/type_selection_screen.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Publication/model/publication.dart';
import 'package:lineclass/Publication/ui/widgets/description_input_publication.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/buttons/gray_button.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:lineclass/widgets/own_appbar.dart';
import 'package:lineclass/widgets/title_input.dart';
import 'package:lineclass/Content/ui/widgets/content_type_button.dart';
import 'package:toast/toast.dart';

class CreatePublicationScreen extends StatefulWidget {

  final User user;
  final Course course;

  CreatePublicationScreen({Key key, @required this.user, @required this.course});

  @override
  _CreatePublicationScreenState createState() => _CreatePublicationScreenState();
}

class _CreatePublicationScreenState extends State<CreatePublicationScreen> {

  /// We create a state for control the Form
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  /// And a Contents List
  List <Content> _contents = [];
  List <Content> _contentsState = [];

  List <DocumentReference> _contentsReferences = [];
  List <DocumentReference> _contentsReferencesState = [];

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    AppBloc bloc = BlocProvider.of <AppBloc> (context);

    /// Form that contains the title and description text fields. The fields already exists.
    Container form = Container(
      child: FormBuilder(
        key: _fbKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            TitleInput(hintText: "Escribe un título...", requiredErrorText: "Título requerido",),
            DescriptionInputPublication()
          ],
        )
      )
    );

    /// Title of Contents
    Widget contentsTitle = Container(
      width: screenWidth*0.5,
      child: Text("Contenido", style: TextStyle(
        fontSize: 20,
        fontFamily: "Comfortaa"
        ),
      ),
      padding: EdgeInsets.only(left: 25, right: 20),
    );

    /// Function that allows to add a Content and then, back to this screen to add a Content to a Publication
    _createAndReturnContent(BuildContext context) async {

      final selectedContent = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TypeSelectionScreen(user: widget.user,)),
      ) ?? "";

      if(selectedContent != "") {

        _contents.add(selectedContent);
        _contentsReferences.add(selectedContent.documentReference);

        setState(() {
          _contentsState = _contents;
          _contentsReferencesState = _contentsReferences;
        });

      }

    }

    Widget addContent = GrayButton(
      width: screenWidth*0.5,
      onPressed: (){

        Toast.show("Datos guardados temporalmente", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

        _createAndReturnContent(context);

      },
      buttonText: "Añadir",
      iconData: Icons.add,
    );

    Widget headerContents = Container(
      margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: <Widget>[
            contentsTitle,
            addContent
          ],
        )
    );

    List<Widget> contentsList (List <Content> contents) {

      List<Widget> contentsInsideList = [];

      contentsInsideList.add(Divider(thickness: 0.9, height: 1,));

        contents.forEach((content) {
          Widget oneContent = ContentTypeButton(function: (){}, type: content.type, typeName: content.title);
          contentsInsideList.add(oneContent);
        });

      return contentsInsideList;

    }

    Future <void> _submit () async {

      bool internetConnexion = await DataConnectionChecker().hasConnection;

      if (internetConnexion) {

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
            publicationDate: publicationDate,
            contents: _contentsReferencesState
          );

          bloc.publication.createPublication(publication).whenComplete( () {

              Navigator.pop(context);
              Navigator.pop(context);

              Toast.show("¡Publicación hecha!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

          });

        } else {
          Toast.show("Completa los campos requeridos", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
        }

      } else if (!internetConnexion){
        Toast.show("Verifica tu conexión a internet :)", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
      }

    }

    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: OwnAppbar(title: "Agregar Publicación", backFunction: _confirmExit, actionName: "Publicar",actionFunction: _submit,),
        body: Column(
          children: <Widget>[
            form,
            headerContents,
          Container(
            height: screenHeight*0.4,
            child: ListView(
              shrinkWrap: true,
              children: contentsList(_contentsState)
              ),
          ),
          ],
        )
      ),
    );
  }

  /// Alert Dialog for confirm if User really wants to exit and discard the Publication
  Future <bool> _confirmExit() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must not tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Deseas salir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Perderás el contenido de tu publicación.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('VOLVER', style: TextStyle(color: Color(0xFF163172)),),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('SALIR', style: TextStyle(color: Color(0xFF163172)),),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
