import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/ui/screens/text_creation_screen.dart';
import 'package:lineclass/Content/ui/screens/youtube_video_creation_screen.dart';
import 'package:lineclass/Content/ui/widgets/type_selection_button.dart';
import 'package:lineclass/User/model/user.dart';

import 'local_file_creation_screen.dart';

class TypeSelectionScreen extends StatelessWidget {

  final User user;

  const TypeSelectionScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List <String> allowedFileExtensions = ["pdf", "svg", "doc", "docx", "txt", "xls", "xlsx", "ppt",
      "rtf", "csv", "zip", "rar", "html", "css", "apk"];

    Content content;
    final double screenWidth = MediaQuery.of(context).size.width;

    _localFileCreation () async {

      await FilePicker.getMultiFile(type: FileType.custom, allowedExtensions: allowedFileExtensions).then(
              (values) async {

            if (values != null){

              content = Content(type: "local_file", description: "", files: values, urlFiles: <String>[]);

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

    _textCreation () async {

              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextCreationScreen()),
              ).then((onValue){

                if (onValue != null){
                  Navigator.pop(context, onValue);
                }

              }).catchError((onError){
                print("$onError ERROR");
      });

    }

    _youtubeVideoCreation () async {

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YoutubeVideoCreationScreen()),
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
      appBar: AppBar(
        title: Text('Escoge una opción', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
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
      ),
      body: Container(
        width: screenWidth,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                TypeSelectionButton(typeString: "Archivo", type: "local_file", function: _localFileCreation,),
                TypeSelectionButton(typeString: "Video de Youtube",  type: "youtube_video", function: _youtubeVideoCreation),
              ],
            ),
            Row(
              children: <Widget>[
                TypeSelectionButton(typeString: "Texto",  type: "text", function: _textCreation,),
                TypeSelectionButton(typeString: "Imagen",  type: "image", function: _imageCreation,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}