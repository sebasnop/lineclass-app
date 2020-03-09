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
  List members;

  Course({
    Key key,
    this.id,
    this.name,
    this.thematic,
    this.creationDate,
    this.institution,
    this.code,
    this.courseOwner,
    this.members
  });
}