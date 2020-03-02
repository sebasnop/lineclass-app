import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/User/repository/cloud_firestore_api.dart';
import 'package:lineclass/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {

  // Casos de uso de Firestore:
  final _cloudFirestoreRepository = CloudFirestoreRepository();

    // Crear o actualizar curso
  Future <void> updateCourseData (Course course) => _cloudFirestoreRepository.updateCourseData(course);

    // Traer todos los cursos
  Future <List> allCourses () => _cloudFirestoreRepository.allCourses();

  @override
  void dispose() {
    // TODO: implement dispose
  }

}