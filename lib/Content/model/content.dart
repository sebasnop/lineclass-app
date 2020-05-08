import 'dart:io';

import 'package:flutter/material.dart';

class Content {

  String id;
  String title;
  String description;
  String type;
  List <File> files;
  List <String> urlFiles;

  Content({Key key, this.title, this.description, @required this.type, this.files, this.id, this.urlFiles});

}