import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/Course/repository/courses_firestore_api.dart';
import 'package:lineclass/Course/repository/courses_firestore_repository.dart';
import 'package:lineclass/User/model/user.dart';

class CourseBloc implements Bloc {


  /// CASOS DE USO DE FIRESTORE CURSOS

  final _coursesFirestoreRepository = CoursesFirestoreRepository();

  /// Crear curso
  Future <void> createCourse (Course course) => _coursesFirestoreRepository.createCourse(course);

  /// Actualizar miembros de un curso
  void updateCourseMembers (Course course) => _coursesFirestoreRepository.updateCourseMembers(course);

  /// Traer todos los cursos como una lista de snapshots de documents
  Future <List> ownCourses (DocumentReference userReference) => _coursesFirestoreRepository.ownCourses(userReference);

  /// Instanciar una lista de cursos con el mismo código para saber si está repetido
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code)
  => _coursesFirestoreRepository.repeatedListCourses(coursesListSnapshot, code);

  Future <List> allCourses () => _coursesFirestoreRepository.allCourses();

  ///Traer la referencia del document del curso
  DocumentReference getCourseReference (String courseId) => _coursesFirestoreRepository.getCourseReference(courseId);

  ///  VISTA

  Stream<List <QuerySnapshot>> coursesListStream (DocumentReference userReference) {

      Stream <QuerySnapshot> studentCourses = Firestore.instance.collection(
          CoursesFirestoreAPI().courses).where("members", arrayContains: userReference).snapshots();

      Stream <QuerySnapshot> teacherCourses = Firestore.instance.collection(
          CoursesFirestoreAPI().courses).where("courseOwner", isEqualTo: userReference).snapshots();

      return StreamZip([studentCourses, teacherCourses]);

    }

  /// Construir cada card de los cursos del usuario
  List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot, User user, int role)
  => _coursesFirestoreRepository.buildCourses(coursesListSnapshot, user, role);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}