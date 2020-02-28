import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Course/model/course.dart';

class CloudFirestoreAPI {

  final courses = "course";

  final Firestore _db = Firestore.instance;

  Future<void> updatePlaceData(Course course) async {

    CollectionReference refCourses = _db.collection(courses);

    await refCourses.add({
      'name' : course.name,
      'identifier': course.identifier,
      'creationDate': course.creationDate,
      'code': course.code
    });

  }

}