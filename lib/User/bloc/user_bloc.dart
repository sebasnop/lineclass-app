import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/repository/cloud_firestore_api.dart';
import 'package:lineclass/User/repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {

  // Casos de uso de Firestore:
  final _cloudFirestoreRepository = CloudFirestoreRepository();

    // Crear o actualizar curso
  Future <void> updateCourseData (Course course) => _cloudFirestoreRepository.updateCourseData(course);

    // Traer todos los cursos
  Future <List> allCourses () => _cloudFirestoreRepository.allCourses();

  ///List <Course> listCourses (List<DocumentSnapshot> coursesListSnapshot)
  ///=> _cloudFirestoreRepository.listCourses(coursesListSnapshot);

  Stream<QuerySnapshot> coursesListStream = Firestore.instance.collection(CloudFirestoreAPI().courses).snapshots();
  Stream<QuerySnapshot> get coursesStream => coursesListStream;

  List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot)
  => _cloudFirestoreRepository.buildCourses(coursesListSnapshot);

    // Instanciar una lista de cursos con el mismo código para saber si está repetido
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code)
  => _cloudFirestoreRepository.repeatedListCourses(coursesListSnapshot, code);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}