import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/widgets/cards/two_line_list_card.dart';

class ContentTypeButton extends StatelessWidget {

  final VoidCallback function;
  final String typeName;
  final String description;
  final String type;

  const ContentTypeButton({Key key, @required this.function, this.typeName, this.type, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final Color iconColor = Color(0xFF545454);
    final double iconSize = 30;
    Widget icon;

    String defaultDescription;

    switch (type) {
      case "youtubeVideo" :
        {
          icon = Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage("assets/youtube.png"))
            ),
          );

          defaultDescription = "Video de Youtube";
        }
      break;
      case "localFile" :
        {
          icon = Icon(Icons.description, color: iconColor, size: iconSize,);
          defaultDescription = "Archivo";
        }
      break;
      case "image" :
        {
          icon = Icon(Icons.burst_mode, color: iconColor, size: iconSize,);
          defaultDescription = "Imagen";
        }
      break;
      case "link" :
        {
        icon = Icon(Icons.share, color: iconColor, size: iconSize,);
        defaultDescription = "Enlace Web";
        }
      break;
      case "text" :
        {
          icon = Icon(Icons.title, color: iconColor, size: iconSize,);
          defaultDescription = "Texto";
        }
      break;
      case "photo" :
        {
          icon = Icon(Icons.camera_alt, color: iconColor, size: iconSize,);
          defaultDescription = "Foto";
        }
      break;
      case "audio" :
        {
          icon = Icon(Icons.keyboard_voice, color: iconColor, size: iconSize,);
          defaultDescription = "Nota de voz";
        }
      break;
      default:
        {
        icon = Icon(Icons.all_inclusive, color: iconColor, size: iconSize,);
        defaultDescription = "Contenido";
        }
    }

    return TwoLineListCard(screenWidth: screenWidth, icon: icon, title: typeName,
        description: description ?? defaultDescription, function: function);

  }
}
