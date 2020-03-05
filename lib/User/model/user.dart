import 'package:flutter/material.dart';

class User {

  String firstName;
  String name;
  String photoUrl;

  User({
    Key key,
    @required this.firstName,
    @required this.photoUrl,
    @required this.name,
  });

}