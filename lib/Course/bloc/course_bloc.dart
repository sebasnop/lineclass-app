import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/Course/repository/courses_firestore_api.dart';
import 'package:lineclass/Course/repository/courses_firestore_repository.dart';

class CourseBloc implements Bloc {



  /// CASOS DE USO DE FIRESTORE CURSOS

  final _coursesFirestoreRepository = CoursesFirestoreRepository();

  /// Crear curso
  Future <void> createCourse (Course course) => _coursesFirestoreRepository.createCourse(course);

  /// Actualizar miembros de un curso
  void updateCourseMembers (Course course) => _coursesFirestoreRepository.updateCourseMembers(course);

  /// Traer todos los cursos
  Future <List> allCourses (DocumentReference userReference) => _coursesFirestoreRepository.ownCourses(userReference);

  /// Instanciar una lista de cursos con el mismo código para saber si está repetido
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code)
  => _coursesFirestoreRepository.repeatedListCourses(coursesListSnapshot, code);


  /// Vista de cursos:

  // Traer los cursos en tiempo real como vista
  Stream<QuerySnapshot> coursesListStream = Firestore.instance.collection(CoursesFirestoreAPI().courses).snapshots();

  // Construir cada card de los cursos que sean
  List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot)
  => _coursesFirestoreRepository.buildCourses(coursesListSnapshot);




  @override
  void dispose() {
    // TODO: implement dispose
  }

}