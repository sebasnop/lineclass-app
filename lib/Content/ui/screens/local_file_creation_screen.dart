import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:lineclass/widgets/title_input.dart';
import 'package:toast/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: must_be_immutable
class LocalFileCreationScreen extends StatefulWidget {

  Content content;
  final User user;

  LocalFileCreationScreen({Key key, @required this.content, @required this.user});

  @override
  _LocalFileCreationScreen createState() => _LocalFileCreationScreen();
}

class _LocalFileCreationScreen extends State<LocalFileCreationScreen> {

  String _uploadedFileURL;

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    AppBloc bloc = BlocProvider.of <AppBloc> (context);

    Container form = Container(
        child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                TitleInput(hintText: "Dale un nombre...", requiredErrorText: "Escribe un título",),
              ],
            )
        )
    );

    _submit () async {
      if (_fbKey.currentState.saveAndValidate()) {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              LoadingScreen(text: "Subiendo Archivos...",)),
        );

        String title = _fbKey.currentState.value["title"];

        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child("${widget.user.uid}/local_files/${title.trim()}-${widget.content.file
            .lastAccessedSync() ?? ""}");
        StorageUploadTask uploadTask = storageReference.putFile(widget.content.file);

        await uploadTask.onComplete;
        print("125 local_file_creation File Uploaded");
        storageReference.getDownloadURL().then((fileURL) {
          setState(() {
            _uploadedFileURL = fileURL.toString();
          });

          widget.content.urlFile = _uploadedFileURL;
          widget.content.title = title;

          print (widget.content.urlFile);

          bloc.content.createContent(widget.content).whenComplete( () {
            Navigator.pop(context, widget.content);
            Navigator.pop(context, widget.content);
            Toast.show("¡Archivo añadido correctamente!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
          });

        });

      } else {
        Toast.show("Completa los campos requeridos", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Agregar Archivos', style: TextStyle(color: Colors.black, fontFamily: "Comfortaa"),),
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Column(
        children: <Widget>[
          form
        ],
      ),
    );

  }

  Future uploadFile(String title, File _file) async {

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("${widget.user.uid}/local_files/${title.trim()}-${_file
        .lastAccessedSync() ?? ""}");
    StorageUploadTask uploadTask = storageReference.putFile(_file);

    await uploadTask.onComplete;
    print("125 local_file_creation File Uploaded");
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL.toString();
      });

    });

  }

}
