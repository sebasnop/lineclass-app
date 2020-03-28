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
  });

}