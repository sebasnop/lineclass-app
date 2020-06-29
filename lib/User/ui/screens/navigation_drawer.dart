import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/ui/screens/home_courses.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/ui/screens/user_settings_screen.dart';
import 'package:lineclass/User/ui/widgets/avatar_picture.dart';

class NavigationDrawer extends StatefulWidget {

  final User user;

  NavigationDrawer({Key key, @required this.user});

  /// We create an state because is necessarily to control what screen is displayed
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  int _selectDrawerScreen = 0;
  String _selectDrawerTitle = "Lineclass";

  /// State options that controls the Main Navigation in the App with the Drawer declared later on Scaffold.
  _getDrawerScreen(int position) {
    switch (position){
      case 0 : return HomeCourses(user: widget.user);
      case 1 : return HomeCourses(user: widget.user);
      case 2 : return UserSettingsScreen(user: widget.user);
    }
  }

  ///Change the Appbar name according to the current screen
  _onSelectDrawerOption (int option, String title) {
    setState(() {
      _selectDrawerScreen = option;
      _selectDrawerTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {

    /// Return a Scaffold with:
        /// An Appbar with the name of the current screen.
        /// A Drawer to control the app navigation with the states options declared previously.

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1E56A0),
        title: Container(
          padding: EdgeInsets.only(top:4),
          child: Text(
            _selectDrawerTitle,
            style: TextStyle(
                fontFamily:"Comfortaa", fontWeight: FontWeight.w500, letterSpacing: 0.5, fontSize: 24
            ),
          ),
        )
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text (widget.user.name, style: TextStyle(fontFamily: "Comfortaa", fontWeight: FontWeight.w600),),
              accountEmail: Text (widget.user.email, style: TextStyle(fontFamily: "Comfortaa", fontSize: 13)),
              currentAccountPicture: AvatarPicture(user: widget.user, side: 30,),
              decoration: BoxDecoration(
                  color: Color(0xFF1E56A0),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
            ),
            ListTile(
              title: Text("Tus cursos", style: TextStyle(fontFamily: "Comfortaa", fontSize: 17),),
              leading: Icon(Icons.home),
              onTap: (){
                _onSelectDrawerOption(0, "Lineclass");
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Mensajes", style: TextStyle(fontFamily: "Comfortaa", fontSize: 17),),
              leading: Icon(CupertinoIcons.mail_solid),
              onTap: (){
                _onSelectDrawerOption(1, "Lineclass");
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Configuración", style: TextStyle(fontFamily: "Comfortaa", fontSize: 17),),
              leading: Icon(CupertinoIcons.gear_big),
              onTap: (){
                _onSelectDrawerOption(2, "Configuración");
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: _getDrawerScreen(_selectDrawerScreen),
    );
  }
}
