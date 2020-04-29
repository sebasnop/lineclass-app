import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TypeSelectionScreen extends StatelessWidget {

  List <String> contentsList;

  TypeSelectionScreen({Key key, @required this.contentsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  Navigator.pop(context, 'Archivo');
                },
                child: Text('Archivo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Nope!" as the result.
                  Navigator.pop(context, 'Video');
                },
                child: Text('Video'),
              ),
            )
          ],
        ),
      ),
    );
  }
}