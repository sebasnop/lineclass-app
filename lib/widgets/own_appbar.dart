import 'package:flutter/material.dart';

class OwnAppbar extends StatelessWidget  with PreferredSizeWidget {

  final String title;
  final Function backFunction;
  final List <Widget> actions;
  final String actionName;
  final Function actionFunction;
  final Color backgroundColor;
  final double elevation;

  OwnAppbar({Key key, this.title, this.backFunction, this.actions, this.actionName,
    this.actionFunction, this.backgroundColor, this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Color(0xFFf6f6f6),
      elevation: elevation ?? 2,
      title: Text(title ?? "Title", style: TextStyle(fontFamily: "Comfortaa", fontSize: 16, color: Colors.black,)),
      leading: InkWell(
          child: Icon(
            Icons.close,
            size: 24,
            color: Colors.black,
          ),
          onTap: backFunction ?? (){}
      ),
      actions: <Widget>[
        InkWell(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10),
            child: Text(
              actionName ?? "Action",
              style: TextStyle(
                  fontFamily: "Comfortaa",
                  fontSize: 16,
                  color: Color(0xFF1E56A0),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          onTap: actionFunction ?? (){},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
