import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeSelectionButton extends StatelessWidget {

  final VoidCallback function;
  final String typeString;
  final String type;

  const TypeSelectionButton({Key key, @required this.function, this.typeString, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Icon icon;

    switch (type) {
      case "youtube_video" : icon = Icon(Icons.ondemand_video, color: Colors.red, size: 60,);
      break;
      case "local_file" : icon = Icon(Icons.insert_drive_file, color: Color(0xFF1e56a0), size: 60,); // Icons.description
      break;
      case "image" : icon = Icon(Icons.collections, color: Colors.lightBlueAccent, size: 60,); //Or Icons.burst_mode
      break;
      case "link" : icon = Icon(Icons.share, color: Colors.teal, size: 60,);
      break;
      case "text" : icon = Icon(Icons.title, color: Color(0xFF163172), size: 60,);
      break;
      case "drive_file" : icon = Icon(Icons.cloud_download, color: Colors.blueAccent, size: 60,);
      break;
      case "audio" : icon = Icon(Icons.keyboard_voice, color: Colors.blueAccent, size: 60,);
      break;
      default: icon = Icon(Icons.all_inclusive, color: Colors.blueAccent, size: 60,);
    }

    final double screenWidth = MediaQuery.of(context).size.width;

    final double containerSide = screenWidth*0.5;
    final containerPadding = containerSide*0.2;

    final buttonSide = containerSide*0.8;
    final buttonPadding = buttonSide*0.07;

    Widget typeText = Container(
        child: Text(typeString, style: TextStyle(color: Colors.black, fontFamily: "Comfortaa", ), textAlign: TextAlign.center,)
    );

    Widget typeIcon = Container(
      margin: EdgeInsets.only(bottom: 10, top: 15),
      child: icon,
    );

    return Container(
      width: containerSide,
      height: containerSide,
      padding: EdgeInsets.only(top: containerPadding, left: containerPadding, right: containerPadding),
      child: MaterialButton(
        padding: EdgeInsets.all(buttonPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        height: buttonSide,
        minWidth: buttonSide,
        onPressed: function,
        color: Color(0xFFf6f6f6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            typeIcon,
            typeText
          ],
        ),
      ),
    );
  }
}
