import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Content {

  String id;
  String title;
  String description;
  String type;
  File file;
  String urlFile;
  DocumentReference documentReference;

  Content({Key key, this.title, this.description, @required this.type, this.file, this.id, this.urlFile, this.documentReference});

}