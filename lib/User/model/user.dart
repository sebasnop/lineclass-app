import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {

  String uid;
  String email;
  String firstName;
  String name;
  String photoUrl;
  Timestamp lastSignIn;

  User({
    Key key,
    @required this.uid,
    @required this.email,
    @required this.firstName,
    @required this.photoUrl,
    @required this.name,
    @required this.lastSignIn,
  });

}