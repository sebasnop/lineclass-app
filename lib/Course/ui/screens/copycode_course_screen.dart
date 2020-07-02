import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/Programacion/Documents/lineclass/lib/widgets/buttons/blue_button.dart';
import 'package:lineclass/widgets/own_exit_button.dart';
import 'package:toast/toast.dart';

class CopycodeCourseScreen extends StatelessWidget {

  final String code;

  CopycodeCourseScreen({Key key, this.code});

  @override
  Widget build(BuildContext context) {

    final int codeLength = code.length;

    String codeOne = "";
    String codeTwo = "";
    String codeThree = "";

    if (codeLength > 20){
    var num = 0;

    for(var i = num ; i <= codeLength-1; i++) {

      if (i <= 20) {

        codeOne = "$codeOne${code[i]}";

      } else if (i > 20 && i <= 40){

        codeTwo = "$codeTwo${code[i]}";

      }

      else if (i > 40 && i <= 60){

        codeThree = "$codeThree${code[i]}";

      }

    }

    } else {
      codeOne = code;
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double backButtonWidth = screenWidth*0.20;

    double screenHeight = MediaQuery.of(context).size.height;

    Widget copyCourseText = Container(
      margin: EdgeInsets.only(bottom: screenHeight*0.08),
        child: Text(
          "El código \ndel curso es",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40,
              color: Color(0xff686868),
              fontFamily: "Comfortaa"
          ),
      ),
    );

    Widget codeCourseBox = Container (
      margin: EdgeInsets.only(bottom: screenHeight*0.03),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: screenHeight*0.15,
            width: screenWidth*0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
                //border: Border.all(color: Color(0xff36C186), width: 1.5),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                //BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 1)
              ]
            ),
          ),
          Text(
            "$codeOne\n$codeTwo\n$codeThree",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );



    Widget copyButton = BlueButton(
      buttonText: "Copiar",
      onPressed: (){
        Clipboard.setData(ClipboardData(text: code));
        Toast.show("¡Código copiado al Portapapeles! :)", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      },
      topMargin: 0,
      bottomMargin: 100,
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          copyCourseText,
          codeCourseBox,
          copyButton,
          OwnExitButton(height: backButtonWidth, width: backButtonWidth, exitText: "Salir")
        ],
      ),
    );
  }

}
