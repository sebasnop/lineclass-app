import 'dart:io';

import 'package:flutter/material.dart';

class Content {

  String title;
  String description;
  String type;
  String url;
  File file;

  Content({Key key, @required this.title, @required this.description, @required this.type,
    this.url, this.file});

}