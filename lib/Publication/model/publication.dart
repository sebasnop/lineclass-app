import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Publication {

  String id;
  String title;
  String description;
  DocumentReference publisher;
  DocumentReference course;

  Publication({
    Key key,
    this.id,
    this.title,
    this.description,
    this.publisher,
    this.course
  });

}