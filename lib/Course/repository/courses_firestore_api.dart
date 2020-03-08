import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';

class CoursesFirestoreAPI {

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

  // Usar la lista de Querys para crear una lista de todos los cursos como cursos
  List <Course> listCourses (List<DocumentSnapshot> coursesListSnapshot) {
    List <Course> courses = List <Course>();

    coursesListSnapshot.forEach(
            (c){

              Course course = Course (code: c.data["code"], institution: c.data["institution"], name: c.data["name"],
                  creationDate: c.data["creationDate"], courseOwner: c.data["courseOwner"], thematic: c.data["thematic"]);

              courses.add(course);

    });

    return courses;

  }

  // Usar la lista de Querys para crear una lista de todos los cursos repetidos como cursos
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code) {

    List <Course> repeatedCourses = List <Course> ();
    coursesListSnapshot.forEach((f){

      if (f.data["code"] == code){
        Course course = Course (code: f.data["code"], creationDate: f.data["creationDate"],
            thematic: f.data["thematic"],name: f.data["name"], institution: f.data["institution"], courseOwner: f.data["userOwner"]);
        repeatedCourses.add(course);
      }

    });

    return repeatedCourses;

    }

    List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot) {

      List <CourseCard> courses = List <CourseCard> ();

      coursesListSnapshot.forEach(
            (c) {
              CourseCard courseCard = CourseCard(
                course: Course (code: c.data["code"], institution: c.data["institution"], name: c.data["name"],
                    creationDate: c.data["creationDate"], courseOwner: c.data["courseOwner"], thematic: c.data["thematic"])
              );

              courses.add(courseCard);

            }
          );

      if (courses.isEmpty){
        CourseCard courseCard = CourseCard(
            course: Course (code: "", institution: "", name: "¡Bienvenido!",
                creationDate: Timestamp.now(), courseOwner: "Añade tu primer curso con el botón de \nabajo a la derecha <3", thematic: "empty")
        );

            courses.add(courseCard);

      }

      return courses;

    }

  }