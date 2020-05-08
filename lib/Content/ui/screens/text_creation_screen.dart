import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/widgets/title_input.dart';
import 'package:toast/toast.dart';

class TextCreationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Content content = Content(type: "text");

    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    Container form = Container(
        child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                TitleInput(hintText: "Dale un nombre...", requiredErrorText: "Escribe un título",),
              ],
            )
        )
    );

    _submit () {

      if (_fbKey.currentState.saveAndValidate()) {

        String title = _fbKey.currentState.value["title"];
        content.title = title;

        Navigator.pop(context, content);

      } else {
        Toast.show("Completa los campos requeridos", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
      }

    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Agregar Texto', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Column(
        children: <Widget>[
          form
        ],
      ),
    );

  }
}
