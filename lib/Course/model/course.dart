import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/User/model/user.dart';

class Course {

  String id;
  String name;
  String thematic;
  String institution;
  Timestamp creationDate;
  String code;
  String courseOwner;

  Course({
    Key key,
    @required this.name,
    @required this.thematic,
    @required this.creationDate,
    @required this.institution,
    @required this.code,
    @required this.courseOwner
  });
}