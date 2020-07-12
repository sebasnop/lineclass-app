import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/ui/screens/text_creation_screen.dart';
import 'package:lineclass/Content/ui/screens/link_creation_screen.dart';
import 'package:lineclass/Content/ui/screens/youtube_video_creation_screen.dart';
import 'package:lineclass/Content/ui/widgets/type_selection_button.dart';
import 'package:lineclass/User/model/user.dart';

import 'image_creation_screen.dart';
import 'local_file_creation_screen.dart';

class TypeSelectionScreen extends StatefulWidget {

  final User user;

  const TypeSelectionScreen({Key key, @required this.user}) : super(key: key);

  @override
  _TypeSelectionScreen createState() => _TypeSelectionScreen();
}

class _TypeSelectionScreen extends State<TypeSelectionScreen> {

  @override
  Widget build(BuildContext context) {

    ///For every option of content that the user can choose for adding we define:
    ///1. Icon(showed knowing type). 2. Title(nameType). 3. Description(description).
    ///Those parameters will be used by the widget called TypeSelectionButton to show every option

    ///Define the keys on the maps that will be used in the Content Type Selection UI
    final List<String> keys = ['type', 'typeName', 'description'];

    ///Define the values on the maps that will be used in the Content Type Selection UI
    final List<String> textValues = ['text', 'Texto', 'Solo escribe texto plano.'];
    final List<String> fileValues = ['localFile', 'Archivo', 'Adjunta un archivo desde tu celular.'];
    final List<String> imageValues = ['image', 'Imagen', 'Selecciona una foto desde tu galería.'];
    final List<String> linkValues = ['link', 'Página Web', 'Comparte el enlace de una web.'];
    final List<String> audioValues = ['audio', 'Audio', 'Graba un audio.'];
    final List<String> youtubeVideoValues = ['youtubeVideo', 'Video de Youtube', 'Comparte el enlace de un video.'];

    ///Define the maps that will be used
    final Map <String, String> text = Map.fromIterables(keys, textValues);
    final Map <String, String> localFile = Map.fromIterables(keys, fileValues);
    final Map <String, String> image = Map.fromIterables(keys, imageValues);
    final Map <String, String> link = Map.fromIterables(keys, linkValues);
    final Map <String, String> audio = Map.fromIterables(keys, audioValues);
    final Map <String, String> youtubeVideo = Map.fromIterables(keys, youtubeVideoValues);

    ///Define the allowed file extensions for _localFileCreation function
    final List <String> allowedFileExtensions = ["pdf", "svg", "doc", "docx", "txt", "xls", "xlsx", "ppt",
      "rtf", "csv", "zip", "rar", "html", "css", "apk"];

    ///Creates the content
    Content content;

    ///Get´s device's width of screen
    final double screenWidth = MediaQuery.of(context).size.width;

    ///Define the function that allows to create text
    _textCreation () async {

      ///Initialize the content
      content = Content(type: text["type"]);

      ///Open the screen to create the text
      await Navigator.push(context, MaterialPageRoute(builder: (context) => TextCreationScreen(content: content, user: widget.user,))

      ).then((onValue){

        if (onValue != null){
          Navigator.pop(context, onValue);
        }

      }).catchError((onError){
        print("$onError ERROR");
      });

    }

    ///Define the function that allows to select allowed files
    _localFileCreation () async {

      ///Open the external screen to select the local file
      await FilePicker.getFile(type: FileType.custom, allowedExtensions: allowedFileExtensions).then(
              (file) async {

            if (file != null){

              ///Initialize the content
              content = Content(type: "localFile", description: "", file: file);

              ///Open the screen to name the content that contains the selected file
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocalFileCreationScreen(content: content, user: widget.user))
              ).then((onValue){

                if (onValue != null){
                  Navigator.pop(context, onValue);
                }

              }).catchError((onError){
                print("87 type_selection_screen $onError ERROR");
              });
            }
          }
      ).catchError((onError){
        print("92 type_selection_screen $onError ERROR");
      });

    }

    ///Define the function that allows to select images
    _imageCreation () async {

      final picker = ImagePicker();

      ///Open the external screen to select the image from gallery
        await picker.getImage(source: ImageSource.gallery,imageQuality: 10).then(
                (pickedFile) async {

              if (image != null){

                final File image = File(pickedFile.path);

                ///Initialize the content
                content = Content(type: "image", description: "", file: image);

                ///Open the screen to name the content that contains the selected file
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageCreationScreen(content: content, user: widget.user)),
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

    ///Define the function that allows to share a link
    _linkCreation () async {

      ///Initialize the content
      content = Content(type: link["type"]);

      ///Open the screen to paste a link
      await Navigator.push(context, MaterialPageRoute(builder: (context) => LinkCreationScreen(content: content, user: widget.user,))

      ).then((onValue){

        if (onValue != null){
          Navigator.pop(context, onValue);
        }

      }).catchError((onError){
        print("$onError ERROR");
      });

    }

    ///Define the function that allows to share a Youtube Video
    _youtubeVideoCreation () async {

      ///Initialize the content
      content = Content(type: youtubeVideo["type"]);

      ///Open the screen to paste a youtube link
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YoutubeVideoCreationScreen(content: content, user: widget.user,)),
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
            TypeSelectionButton(type: localFile["type"], typeName: localFile["typeName"], description: localFile["description"], function: _localFileCreation,),
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