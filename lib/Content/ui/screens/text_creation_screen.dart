import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/title_input.dart';
import 'package:toast/toast.dart';

  ///This screen is a form that allows users to write large texts

// ignore: must_be_immutable
class TextCreationScreen extends StatefulWidget {

  Content content;
  final User user;

  TextCreationScreen({Key key, @required this.content, @required this.user}) : super(key: key);

  @override
  _TextCreationScreenState createState() => _TextCreationScreenState();
}

class _TextCreationScreenState extends State<TextCreationScreen> {

  String successMessage = "¡Texto añadido!";
  String errorMessage = "Carga fallida :c\nPrueba más tarde.";

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    AppBloc bloc = BlocProvider.of <AppBloc> (context);

    Container textInput = Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 400,
          top: 0
      ),
      decoration: BoxDecoration(
      ),
      child: FormBuilderTextField(
        showCursor: true,
        textAlign: TextAlign.left,
        maxLength: 4000,
        attribute: "text",
        keyboardType: TextInputType.multiline,
        cursorColor: Color(0xff979797),
        style: TextStyle(
          fontSize: 17,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: "Escribe aquí :D",
            labelStyle: TextStyle(color:Colors.black12,),
            hintStyle: TextStyle(color: Colors.black26,),
            helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.black26)),
            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.red)),
            errorStyle: TextStyle(
                fontFamily: "Comfortaa",
                color: Colors.red
            ),
            contentPadding: EdgeInsets.only(
                left: 10,
                right: 10,
              bottom: 50
            )
        ),
        validators: [
          FormBuilderValidators.maxLength(4000, errorText: "Debe contener menos letras"),
        ],
      ),
    );

    Container form = Container(
        child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                TitleInput(hintText: "Dale un nombre...", requiredErrorText: "Escribe un título",),
                textInput
              ],
            )
        )
    );

    Future <void> _submit () async {

      bool internetConnexion = await DataConnectionChecker().hasConnection;

      if (internetConnexion) {

        if (_fbKey.currentState.saveAndValidate()) {

          String title = _fbKey.currentState.value["title"];
          String text = _fbKey.currentState.value["text"] ?? "";

          widget.content.title = title;
          widget.content.description = text;

          bloc.content.createContentReference(widget.content).then((documentReference) {

            widget.content.documentReference = documentReference;
            widget.content.id = documentReference.documentID;
            bloc.content.setContentId(documentReference);

            Navigator.pop(context, widget.content);
            Toast.show(successMessage, context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);

          }).catchError((onError){
            print("$onError ERROR on uploadFile");
            Toast.show(errorMessage, context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
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
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Texto', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(
              Icons.close,
              size: 24,
              color: Colors.black,
            ),
            onTap: _confirmExit,
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  "¡Listo!",
                  style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontSize: 16,
                      color: Color(0xFF1E56A0),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onTap: _submit,
            ),
          ],
        ),
        body: ListView(
            shrinkWrap: true,
            children: <Widget>[
            form
          ],
        )
      ),
    );

  }

  /// Alert Dialog for confirm if User really wants to exit and discard the Text's Creation
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
                Text('Perderás el texto escrito.'),
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
