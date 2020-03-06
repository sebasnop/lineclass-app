import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';

import 'cloud_firestore_api.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  Future <void> updateCourseData(Course course) => _cloudFirestoreAPI.updatePlaceData(course);

  Future <List> allCourses () => _cloudFirestoreAPI.allCourses();

  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code)
  => _cloudFirestoreAPI.repeatedListCourses(coursesListSnapshot, code);

  List <Course> listCourses (List<DocumentSnapshot> coursesListSnapshot)
  => _cloudFirestoreAPI.listCourses(coursesListSnapshot);

 List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot)
  => _cloudFirestoreAPI.buildCourses(coursesListSnapshot);

}