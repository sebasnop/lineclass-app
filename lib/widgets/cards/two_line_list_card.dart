import 'package:flutter/material.dart';

class TwoLineListCard extends StatelessWidget {

  ///That's a Two-Line ListCard with a visual support, title and description. Has a divider too. Has not elevation.
  ///Can have a pressing function or not. It's optional.

  final double screenWidth;
  final VoidCallback function;
  final String title;
  final String description;
  final Widget icon;

  const TwoLineListCard({Key key, this.function, @required this.title, this.description,
    @required this.screenWidth, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget visualSupport = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: icon ?? Container(width: 30, height: 30),
    );

    Widget text = Container(
      height: 40,
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              height: 20,
              child: Text(title ?? "", style: TextStyle(color: Colors.black, fontFamily: "Comfortaa", ))
          ),
          Container(
              alignment: Alignment.centerLeft,
              height: 20,
              margin: EdgeInsets.only(left:1),
              child: Text(description ?? "", style: TextStyle(color: Colors.black38, fontFamily: "Comfortaa", fontSize: 12))
          ),
        ],
      ),
    );

    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(0),
          elevation: 0,
          child: InkWell(
            onTap: function ?? (){},
            child: Container(
                padding: EdgeInsets.all(16),
                height: 72,
                width: screenWidth,
                child: Row(
                  children: <Widget>[
                    visualSupport,
                    text
                  ],
                )
            ),
          ),
        ),
        Divider(thickness: 0.9, height: 0,)
      ],
    );
  }
}
