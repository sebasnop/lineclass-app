import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';

import 'courses_firestore_api.dart';

class CoursesFirestoreRepository {

  final _coursesFirestoreAPI = CoursesFirestoreAPI();

  Future <void> updateCourseData(Course course) => _coursesFirestoreAPI.updatePlaceData(course);

  Future <List> allCourses () => _coursesFirestoreAPI.allCourses();

  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code)
  => _coursesFirestoreAPI.repeatedListCourses(coursesListSnapshot, code);

  List <Course> listCourses (List<DocumentSnapshot> coursesListSnapshot)
  => _coursesFirestoreAPI.listCourses(coursesListSnapshot);

 List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot)
  => _coursesFirestoreAPI.buildCourses(coursesListSnapshot);

}