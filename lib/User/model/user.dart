import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {

  String uid;
  String name;
  String email;
  String photoUrl;
  String firstName;
  String firstLastName;
  String secondLastName;
  String nickname;
  Timestamp lastSignIn;

  List <DocumentReference> studentCourses; // Where the User is a student
  List <DocumentReference> teacherCourses; // Where the User is a teacher

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoUrl,
    @required this.firstName,
    this.firstLastName,
    this.secondLastName,
    @required this.nickname,
    @required this.lastSignIn,
    this.studentCourses,
    this.teacherCourses,
  });

}