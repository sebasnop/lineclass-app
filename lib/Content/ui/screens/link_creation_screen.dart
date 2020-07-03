import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/title_input.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class LinkCreationScreen extends StatelessWidget {

  Content content;
  final User user;

  LinkCreationScreen({Key key, @required this.content, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    AppBloc bloc = BlocProvider.of <AppBloc> (context);

    Container textInput = Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 400,
          top: 10
      ),
      child: FormBuilderTextField(
        showCursor: true,
        textAlign: TextAlign.left,
        textCapitalization: TextCapitalization.none,
        attribute: "link",
        keyboardType: TextInputType.url,
        cursorColor: Color(0xff979797),
        style: TextStyle(
          color: Colors.blue,
          fontSize: 16,
          letterSpacing: 0.3,
          fontWeight: FontWeight.w300,
          decoration: TextDecoration.underline
        ),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: "Escribe la url aquí...",
            labelStyle: TextStyle(color:Colors.blue),
            hintStyle: TextStyle(color: Colors.blueGrey),
            helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.black26)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.black26)),
            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.red)),
            errorStyle: TextStyle(
                fontFamily: "Comfortaa",
                color: Colors.red
            ),
            contentPadding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 70
            )
        ),
        validators: [
          FormBuilderValidators.required(errorText: "Escribe una url"),
          FormBuilderValidators.maxLength(2000, errorText: "Prueba con una url más corta"),
          FormBuilderValidators.url(errorText: "Escribe una url válida")
        ],
      ),
    );

    Container form = Container(
        child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                TitleInput(hintText: "Nombre de Web...", requiredErrorText: "Escribe un título",),
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
          String link = _fbKey.currentState.value["link"] ?? "";

          content.title = title;
          content.description = link;

          bloc.content.createContent(content).whenComplete( () {
            Navigator.pop(context, content);
            Toast.show("¡Web añadida!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
          }
          ).catchError((onError){
            print("$onError ERROR on uploadFile");
            Toast.show("Carga fallida :c\nPrueba más tarde.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
          });

        } else {
          Toast.show("Completa los campos requeridos", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
        }

      } else if (!internetConnexion){
        Toast.show("Verifica tu conexión a internet :)", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
      }

    }

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Página Web', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
          backgroundColor: Colors.white,
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
    );

  }
}
