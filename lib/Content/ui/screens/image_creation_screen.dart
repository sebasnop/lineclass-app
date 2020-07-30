import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class ImageCreationScreen extends StatefulWidget {

  Content content;
  final User user;

  ImageCreationScreen({Key key, @required this.content, @required this.user});

  @override
  _ImageCreationScreen createState() => _ImageCreationScreen();
}

class _ImageCreationScreen extends State<ImageCreationScreen> {

  String _uploadedFileURL;

  @override
  Widget build(BuildContext context) {

    AppBloc bloc = BlocProvider.of <AppBloc> (context);
    String imageName = widget.content.file.path.split("/").last;


    ///Get´s device's width of screen
    final double screenWidth = MediaQuery.of(context).size.width;

    _submit () async {

        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            LoadingScreen(text: "Subiendo Archivos...",)),
        );

        StorageReference storageReference = FirebaseStorage.instance.ref()
            .child("${widget.user.uid}/local_files/${imageName.trim()}-${widget.content.file.lastAccessedSync() ?? ""}");

        StorageUploadTask uploadTask = storageReference.putFile(widget.content.file);

        await uploadTask.onComplete;
        print("48 local_file_creation Image Uploaded");
        storageReference.getDownloadURL().then((fileURL) {
          setState(() {
            _uploadedFileURL = fileURL.toString();
          });

          widget.content.urlFile = _uploadedFileURL;
          widget.content.title = imageName;

          print (widget.content.urlFile);

          bloc.content.createContent(widget.content).whenComplete( () {
            Navigator.pop(context, widget.content);
            Navigator.pop(context, widget.content);
            Toast.show("¡Imagen añadida correctamente!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
          });

        });
    }

    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Vista previa', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            child: Icon(
              Icons.close,
              size: 24,
              color: Colors.black,
            ),
            onTap: _confirmExit,
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
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top:20),
                height: screenWidth*0.8,
                width: screenWidth*0.8,
                child: Image.file(widget.content.file,)
              )
            ],
          ),
        ),
      ),
    );

  }

  /// Alert Dialog for confirm if User really wants to exit and discard the Text's Creation
  Future <bool> _confirmExit() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must not tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Deseas salir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Se borrará la imagen seleccionada.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('VOLVER', style: TextStyle(color: Color(0xFF163172)),),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('SALIR', style: TextStyle(color: Color(0xFF163172)),),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}