import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';

class Course {

  String id;
  String name;
  int identifier;
  DateTime creationDate;
  String code;
  //User user;

  Course({
    Key key,
    @required this.name,
    @required this.identifier,
    @required this.creationDate,
    //@required this.code
  });
}