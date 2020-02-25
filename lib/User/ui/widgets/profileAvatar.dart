import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';

class ProfileAvatar extends StatelessWidget {

  //User user;
  double width;
  double height;

  ProfileAvatar({
    Key key,
    //@required user,
    @required width,
    @required height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.black,
    );
  }
}
