import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/Content/ui/widgets/type_selection_button.dart';
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

    String fileName = widget.content.file.path.split("/").last;
    String helperText;
    String fileNameNoExt;

    if (fileName.length < 35) {
      fileNameNoExt = fileName.split(".").first;
      helperText = "Puedes editarlo";
    } else {
      fileNameNoExt = "";
      helperText = "";
    }

    String lastModified= "Última modificación";
    List <String> lastModifiedDate = widget.content.file.lastModifiedSync().toString().split(":");
    String fileDescription = "$lastModified ${lastModifiedDate[0]}:${lastModifiedDate[1]}";

    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    AppBloc bloc = BlocProvider.of <AppBloc> (context);

    Container form = Container(
        child: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                TitleInput(hintText: "Dale un nombre...", requiredErrorText: "Escribe un título",
                  initialValue: fileNameNoExt, autoFocus: false, helperText: helperText,)
              ],
            )
        )
    );

    _submit () async {
      if (_fbKey.currentState.saveAndValidate()) {

        Navigator.push(context, MaterialPageRoute(builder: (context) =>
              LoadingScreen(text: "Subiendo Archivos...",)),
        );

        String title = _fbKey.currentState.value["title"];

        StorageReference storageReference = FirebaseStorage.instance.ref()
            .child("${widget.user.uid}/local_files/${title.trim()}-${widget.content.file.lastAccessedSync() ?? ""}");

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

    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
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
        body: Column(
          children: <Widget>[
            form,
            TypeSelectionButton(function: (){}, type: "localFile", typeName: fileName, description: fileDescription,)
          ],
        ),
      ),
    );

  }

  /// Alert Dialog for confirm if User really wants to exit and discard the Publication
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
                Text('Se borrará el archivo seleccionado.'),
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
