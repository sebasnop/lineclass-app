import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Content/model/content.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/bloc.dart';
import 'package:lineclass/widgets/loading_screen.dart';
import 'package:lineclass/widgets/title_input.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class LocalFileCreationScreen extends StatelessWidget {

  Content content;
  final User user;

  LocalFileCreationScreen({Key key, @required this.content, @required this.user});

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

    _submit () {

      if (_fbKey.currentState.saveAndValidate()) {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoadingScreen(text: "Subiendo Archivos...",)),
        );

        String title = _fbKey.currentState.value["title"];

        List <String> test () {

          List <String> urls = [];

          content.files.forEach(
                  (file) {

                ///Se sube el archivo a Firebase Storage
                bloc.content.uploadFile("${user.uid}/local_files/${title.trim()}-${file.lastAccessedSync() ?? ""}", file).then(

                  /// Cuando se complete la subida...
                        (StorageUploadTask storageUploadTask){

                      ///Entonces se verificará que la tarea haya sido completada...
                      storageUploadTask.onComplete.then(
                              (StorageTaskSnapshot snapshot){

                            ///Se obtendrá la url del archivo
                            snapshot.ref.getDownloadURL().then((urlImage){

                              /// Y se añadirá cada url a la lista de urls del contenido
                              urls.add(urlImage);

                            }).catchError((onError){
                              print("$onError ERROR on getDownloadURL");
                            });

                          }).catchError((onError){
                        print("$onError ERROR on storageUploadTask");
                      });

                    }).catchError((onError){
                  print("$onError ERROR on uploadFile");
                });

              }
          );

          return urls;

        }

        content.urlFiles = test();
        content.title = title;
        
        bloc.content.createContent(content).whenComplete( () {
          Navigator.pop(context, content);
          Navigator.pop(context, content);
          Toast.show("¡Carga exitosa!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
        }
        ).catchError((onError){
          print("$onError ERROR on uploadFile");
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
            Icons.keyboard_arrow_left,
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
}
