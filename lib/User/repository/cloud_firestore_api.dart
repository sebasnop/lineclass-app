import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Course/model/course.dart';

class CloudFirestoreAPI {

  final courses = "courses";
  final Firestore _db = Firestore.instance;

  // Crear o actualizar un usuario
  Future <void> updatePlaceData(Course course) async {

    CollectionReference refCourses = _db.collection(courses);

    await refCourses.add({
      'name' : course.name,
      'institution': course.institution,
      'creationDate': course.creationDate,
      'thematic': course.thematic,
      'code': course.code,
      'courseOwner': course.courseOwner
    });

  }

  // Instanciar una Lista de Querys con todos los cursos como documentos
  Future <List> allCourses () async {

    CollectionReference refCourses = _db.collection(courses);

    QuerySnapshot querySnapshot = await refCourses.getDocuments();
    return querySnapshot.documents;

  }

  //Usar la lista de Querys para crear una lista de todos los cursos como cursos
  List <Course> listCourses (List<DocumentSnapshot> coursesListSnapshot) {
    List <Course> courses = List <Course>();

    coursesListSnapshot.forEach(
            (c){

              Timestamp.now();

              Course course = Course (code: c.data["code"], institution: c.data["institution"], name: c.data["name"],
                  creationDate: c.data["creationDate"], courseOwner: c.data["courseOwner"], thematic: c.data["thematic"]);
    });

    return courses;

  }


}