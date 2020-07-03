import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/ui/screens/text_creation_screen.dart';
import 'package:lineclass/Content/ui/screens/link_creation_screen.dart';
import 'package:lineclass/Content/ui/screens/youtube_video_creation_screen.dart';
import 'package:lineclass/Content/ui/widgets/type_selection_button.dart';
import 'package:lineclass/User/model/user.dart';

import 'local_file_creation_screen.dart';

class TypeSelectionScreen extends StatelessWidget {

  final User user;

  const TypeSelectionScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<String> keys = ['type', 'typeName', 'description'];

    final List<String> textValues = ['text', 'Texto', 'Solo escribe texto plano.'];
    final List<String> fileValues = ['localFile', 'Archivo', 'Adjunta archivos desde tu celular.'];
    final List<String> imageValues = ['image', 'Imágenes', 'Selecciona fotos desde tu galería.'];
    final List<String> linkValues = ['link', 'Página Web', 'Comparte el enlace de una web.'];
    final List<String> audioValues = ['audio', 'Audio', 'Graba un audio.'];
    final List<String> youtubeVideoValues = ['youtubeVideo', 'Video de Youtube', 'Comparte el enlace de un video.'];

    final Map <String, String> text = Map.fromIterables(keys, textValues);
    final Map <String, String> file = Map.fromIterables(keys, fileValues);
    final Map <String, String> image = Map.fromIterables(keys, imageValues);
    final Map <String, String> link = Map.fromIterables(keys, linkValues);
    final Map <String, String> audio = Map.fromIterables(keys, audioValues);
    final Map <String, String> youtubeVideo = Map.fromIterables(keys, youtubeVideoValues);

    final List <String> allowedFileExtensions = ["pdf", "svg", "doc", "docx", "txt", "xls", "xlsx", "ppt",
      "rtf", "csv", "zip", "rar", "html", "css", "apk"];

    Content content;
    final double screenWidth = MediaQuery.of(context).size.width;

    _textCreation () async {

      content = Content(type: text["type"]);
      await Navigator.push(context, MaterialPageRoute(builder: (context) => TextCreationScreen(content: content, user: user,))

      ).then((onValue){

        if (onValue != null){
          Navigator.pop(context, onValue);
        }

      }).catchError((onError){
        print("$onError ERROR");
      });

    }

    _localFileCreation () async {

      await FilePicker.getMultiFile(type: FileType.custom, allowedExtensions: allowedFileExtensions).then(
              (values) async {

            if (values != null){

              content = Content(type: "localFile", description: "", files: values, urlFiles: <String>[]);

              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocalFileCreationScreen(content: content, user: user,)),
              ).then((onValue){

                if (onValue != null){
                  Navigator.pop(context, onValue);
                }

              });
            }
          }
      ).catchError((onError){
        print("$onError ERROR");
      });

    }

    _imageCreation () async {

      await FilePicker.getFile(type: FileType.image).then(
              (photo) async {

            if (photo != null){

              content = Content(type: "image", description: "", files: [photo]);

              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocalFileCreationScreen(content: content, user: user)),
              ).then((onValue){

                if (onValue != null){
                  Navigator.pop(context, onValue);
                }

              });
            }
          }
      ).catchError((onError){
        print("$onError ERROR");
      });

    }

    _linkCreation () async {

      content = Content(type: link["type"]);
      await Navigator.push(context, MaterialPageRoute(builder: (context) => LinkCreationScreen(content: content, user: user,))

      ).then((onValue){

        if (onValue != null){
          Navigator.pop(context, onValue);
        }

      }).catchError((onError){
        print("$onError ERROR");
      });

    }

    _youtubeVideoCreation () async {

      content = Content(type: youtubeVideo["type"]);
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YoutubeVideoCreationScreen(content: content, user: user,)),
      ).then((onValue){

        if (onValue != null){
          Navigator.pop(context, onValue);
        }

      }).catchError((onError){
        print("$onError ERROR");
      });

    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text("Escoge una opción...", style: TextStyle(fontFamily: "Comfortaa", fontSize: 16, color: Colors.black,)),
        leading: InkWell(
          child: Icon(
            Icons.close,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: screenWidth,
        child: ListView(
          padding: EdgeInsets.only(bottom:8, top:8),
          children: <Widget>[
            TypeSelectionButton(type: text["type"], typeName: text["typeName"], description: text["description"], function: _textCreation,),
            TypeSelectionButton(type: file["type"], typeName: file["typeName"], description: file["description"], function: _localFileCreation,),
            TypeSelectionButton(type: image["type"], typeName: image["typeName"], description: image["description"], function: _imageCreation,),
            TypeSelectionButton(type: audio["type"], typeName: audio["typeName"], description: audio["description"], function: _textCreation,),
            TypeSelectionButton(type: link["type"], typeName: link["typeName"], description: link["description"], function: _linkCreation,),
            TypeSelectionButton(type: youtubeVideo["type"], typeName: youtubeVideo["typeName"],
                description: youtubeVideo["description"], function: _youtubeVideoCreation)
          ],
        ),
      ),
    );
  }
}