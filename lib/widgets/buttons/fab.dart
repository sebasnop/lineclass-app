import 'package:flutter/material.dart';

class Fab extends StatefulWidget {

  final VoidCallback onPressed;

  final bool mini;
  final IconData icon;
  final double iconSize;
  final Color color = Color(0xff1e56a0);
  final secondColor = Colors.blue;

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
            child: Icon(widget.icon, size: widget.iconSize, color: Colors.white,),
          ),
        )
    );

  }
}
