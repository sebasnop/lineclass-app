import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnAppBar extends StatelessWidget {

  double width; // Recibiremos el ancho de la pantalla para construir el appbar.
  double height;

  OwnAppBar({
    Key key,
    @required this.width,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {

    double widthBanner = (this.width*63)/100; // Ancho del banner dentro del appbar. Es el 63 % del ancho de pantalla.
    double widthConfig = (this.width*37)/100; // Ancho restante del banner, que es el espacio para la configuración.

    double heightSafeArea = 24;
    double heightBanner = height - heightSafeArea;

    Widget safeArea = Container(
      height: heightSafeArea,
      width: width,
      color: Color(0xff36C186)
    );

    Widget banner = Container(
      width: widthBanner,
      height: heightBanner,
      color: Color(0xff36C186),
      alignment: Alignment(0, 1),
      padding: EdgeInsets.only(
        left: 13
      ),
      child: Row(
        children: <Widget>[
          Container(
              height: heightBanner,
              width: heightBanner,
              child: Image(
                  image: AssetImage("assets/logo.png")
              )
          ),
          Container(
            padding: EdgeInsets.only(
              left: 13,
              top: 4
            ),
            child: Text(
              "Lineclass",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600
              ),
            ),
          )
        ],
      ),
    );

    Widget config = Container(
      width: widthConfig,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(
        right: 16
      ),
      child: Icon(CupertinoIcons.gear_big, color: Colors.black54, size: 24,),
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
          boxShadow: <BoxShadow>[
            BoxShadow (
                color:  Colors.black38,
                blurRadius: 2
            )
          ]
      ),
      child: Column(
        children: <Widget>[
          safeArea,
          Row(
            children: <Widget>[
              banner,
              config
            ],
          )
        ],
      ),
    );
  }
}
