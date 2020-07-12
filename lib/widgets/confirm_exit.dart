import 'package:flutter/material.dart';

class ConfirmExit {

  final BuildContext context;

  ConfirmExit({Key key, @required this.context});

  Future<bool> Function () alv = () async{

    return showDialog<bool>(
      //context: context,
      barrierDismissible: true, // user must not tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Deseas salir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Perderás el contenido de tu publicación.'),
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
  };

  /// Alert Dialog for confirm if User really wants to exit and discard the Publication
  Future <bool> confirmExit() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must not tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Deseas salir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Perderás el contenido de tu publicación.'),
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
