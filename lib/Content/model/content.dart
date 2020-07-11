import 'dart:io';

import 'package:flutter/material.dart';

class Content {

  String id;
  String title;
  String description;
  String type;
  File file;
  String urlFile;

  Content({Key key, this.title, this.description, @required this.type, this.file, this.id, this.urlFile});

}