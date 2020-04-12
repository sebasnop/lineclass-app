import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Publication {

  String id;
  String title;
  String description;
  DocumentReference publisher;
  DocumentReference course;
  Timestamp publicationDate;

  Publication({
    Key key,
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.publisher,
    @required this.course,
    @required this.publicationDate
  });

}