import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';

import 'cloud_firestore_api.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  Future <void> updateCourseData(Course course) => _cloudFirestoreAPI.updatePlaceData(course);

  Future <List> allCourses () => _cloudFirestoreAPI.allCourses();

}