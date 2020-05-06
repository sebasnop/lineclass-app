import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Content/model/content.dart';

// ignore: must_be_immutable
class TypeSelectionScreen extends StatelessWidget {

  Content content;

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: MaterialButton(
                color: Color(0xFFf6f6f6),
                elevation: 1,
                onPressed: () async {



                  await FilePicker.getFile(type: FileType.any).then(
                      (value){

                        content = Content(title: "Archivo Local", type: "local_file", description: "", file: value);

                        Navigator.pop(context, content);

                        }
                    ).catchError((onError){
                      print("$onError ERROR");
                  });



                },
                child: Text('Archivo', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: 1,
                color: Color(0xFFf6f6f6),
                onPressed: () {

                  content = Content(title: "Video de Youtube", type: "youtube_video", description: "", url: "");

                  Navigator.pop(context, content);
                },
                child: Text('Video de Youtube', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
              ),
            )
          ],
        ),
      ),
    );
  }
}