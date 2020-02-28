import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {

  // Casos de uso de Firestore:
  final _cloudFirestoreRepository = CloudFirestoreRepository();

    // Crear o actualizar curso
  Future <void> updateCourseData (Course course) => _cloudFirestoreRepository.updateCourseData(course);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}