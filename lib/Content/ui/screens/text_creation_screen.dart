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

    Container textInput = Container(
      margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 200,
          top: 0
      ),
      padding: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
      ),
      child: FormBuilderTextField(
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
            hintText: "Escribe aquí :)",
            labelStyle: TextStyle(color:Colors.black12,),
            hintStyle: TextStyle(color: Colors.black26,),
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
              bottom: 100
            )
        ),
        validators: [
          FormBuilderValidators.maxLength(2000, errorText: "Debe contener menos letras"),
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
        title: Text('Texto', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
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
