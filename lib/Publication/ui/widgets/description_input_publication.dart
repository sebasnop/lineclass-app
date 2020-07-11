import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DescriptionInputPublication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /// Make a Text Field for the Publication's Description
    return Container(
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
        maxLength: 200,
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
            hintText: "Descripción...\n(Opcional)",
            labelStyle: TextStyle(color:Colors.black12,),
            helperStyle: TextStyle(color:Colors.black38, fontFamily: "Comfortaa",),
            hintStyle: TextStyle(color: Colors.black26,),
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
  }
}
