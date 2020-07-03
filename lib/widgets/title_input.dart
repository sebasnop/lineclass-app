import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TitleInput extends StatelessWidget {

  final String hintText;
  final String requiredErrorText;

  const TitleInput({Key key, @required this.hintText, @required this.requiredErrorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        maxLength: 35,
        autofocus: false,
        attribute: "title",
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.blueGrey,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: hintText,
            helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
            labelStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa"),
            hintStyle: TextStyle(color: Colors.black38, ),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.transparent)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.blueGrey)),
            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide (color: Colors.blueGrey)),
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
          FormBuilderValidators.required(errorText: requiredErrorText),
          FormBuilderValidators.minLength(2, errorText: "Debe contener más letras"),
          FormBuilderValidators.maxLength(35, errorText: "Debe contener menos letras"),
        ],
      ),
    );
  }
}
