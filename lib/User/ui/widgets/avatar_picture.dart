import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';

class AvatarPicture extends StatelessWidget {

  double side;
  User user;

  AvatarPicture({
    Key key,
    @required this.side,
    @required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: side,
      height: side,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow> [BoxShadow(
          color: Colors.black26,
          blurRadius: 2,
          offset: Offset(1, 1)
        )],
          border: Border.all(
              color: Colors.black,
              width: 2.0,
              style: BorderStyle.solid
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(user.photoUrl)
          )
      ),
    );
  }
}
