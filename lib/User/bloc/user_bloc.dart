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

    // Buscar Cursos repetidos
  Stream<QuerySnapshot> coursesListStream(String code) {
    Firestore.instance.collection(CloudFirestoreAPI().courses)
        .where("code", isEqualTo: code)
        .snapshots();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}