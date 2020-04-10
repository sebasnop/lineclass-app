import 'package:flutter/material.dart';

class Fab extends StatefulWidget {

  final VoidCallback onPressed;

  bool mini;
  IconData icon;
  double iconSize;
  Color color = Color(0xff1e56a0);
  Color secondColor = Colors.blue;

  Fab({
    Key key,
    @required this.icon,
    @required this.onPressed,
    @required this.iconSize,
    this.mini
  });

  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton(
          heroTag: null,
          onPressed: widget.onPressed,
          backgroundColor: widget.color,
          splashColor: widget.secondColor,
          elevation: 2,
          child: Container(
            child: Icon(widget.icon, size: widget.iconSize),
          ),
        )
    );

  }
}
