import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/model/user.dart';

class CoursesFirestoreAPI {

  final courses = "courses";
  final users = "users";
  final Firestore _db = Firestore.instance;

  // Crear un curso
  Future <void> createCourse(Course course) async {

    CollectionReference refCourses = _db.collection(courses);

    await refCourses.add({
      'id': course.id,
      'name' : course.name,
      'institution': course.institution,
      'creationDate': course.creationDate,
      'thematic': course.thematic,
      'code': course.code,
      'courseOwner': course.courseOwner,/**_db.document("$users/${course.courseOwner.uid}"),**/
      'members': course.members
    }).then( (DocumentReference dr) {

      String getId = dr.documentID;

      dr.updateData({
        'id': getId
      });

    }
    );

  }

  //Actualizar los miembros de un curso
  void updateCourseMembers (Course course) async {

    DocumentReference ref = _db.collection(courses).document(course.id);

    return await ref.setData({
      'members': course.members
    },
        merge: true
    );

  }

  ///Traer la referencia del document del usuario
  DocumentReference getCourseReference(String courseId) {
    DocumentReference courseReference;
    DocumentReference ref = _db.collection(courses).document(courseId);
    courseReference = ref;
    return courseReference;
  }

  // Instanciar una Lista de Querys con todos los cursos que tienes como profesor como documentos
  Future <List> ownCourses (DocumentReference userReference) async {

    Query refOwnCourses = _db.collection(courses).where("courseOwner", isEqualTo: userReference);

    QuerySnapshot querySnapshot = await refOwnCourses.getDocuments();
    return querySnapshot.documents;

  }

  // Construir un objeto Course a partir de un snapshot

  Course buildCourse (DocumentSnapshot c) {

    // Organizar la lista de miembros
    List <DocumentReference> ifNull = [];
    List<dynamic> superList = c.data["members"]  ?? ifNull;
    List<DocumentReference> subList = List <DocumentReference>.from(superList.whereType<DocumentReference>()) ?? ifNull;

    Course course = Course (code: c.data["code"], institution: c.data["institution"], name: c.data["name"],
        creationDate: c.data["creationDate"], courseOwner: c.data["courseOwner"], thematic: c.data["thematic"],
        id: c.data["id"], members: subList);

    return course;
  }

  // Usar la lista de Querys para crear una lista de todos los cursos repetidos como cursos
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code) {

    List <Course> repeatedCourses = List <Course> ();
    coursesListSnapshot.forEach((c){

      if (c.data["code"] == code){
        Course course = buildCourse(c);
        repeatedCourses.add(course);
      }

    });

    return repeatedCourses;
  }

  Future <List> allCourses () async {

    CollectionReference refOwnCourses = _db.collection(courses);

    QuerySnapshot querySnapshot = await refOwnCourses.getDocuments();
    return querySnapshot.documents;

  }

  // Usar la lista de Querys para crear una lista de todos los cursos como cursos
  List <Course> listCourses (List<DocumentSnapshot> coursesListSnapshot) {
    List <Course> courses = List <Course>();

    coursesListSnapshot.forEach(
            (c){
              Course course = buildCourse(c);
              courses.add(course);
    });

    return courses;
  }

  List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot, User user) {

    List <CourseCard> courseCards = List <CourseCard> ();

    coursesListSnapshot.forEach(
          (c) {

            Course course = buildCourse(c);
            CourseCard courseCard = CourseCard(
              course: course,
              user: user,
            );

            courseCards.add(courseCard);
          }
        );

    if (courseCards.isEmpty){

      List <String> noCourseMessages = ["¡Bienvenido!", "Añade tu primer curso con el botón verde :D", "empty"];

      CourseCard courseCard = CourseCard(
          noCourseMessages: noCourseMessages,
      );

          courseCards.add(courseCard);

    }
    return courseCards;
  }

}