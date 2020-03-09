import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';

class CoursesFirestoreAPI {

  final courses = "courses";
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
      'courseOwner': course.courseOwner,
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

              List <String> ifNull = [];
              List<dynamic> superList = c.data["members"]  ?? ifNull;
              List<String> subList = List <String>.from(superList.whereType<String>()) ?? ifNull;

              Course course = Course (code: c.data["code"], institution: c.data["institution"], name: c.data["name"],
                  creationDate: c.data["creationDate"], courseOwner: c.data["courseOwner"], thematic: c.data["thematic"],
                  id: c.data["id"], members: subList);

              courses.add(course);

    });

    return courses;

  }

  // Usar la lista de Querys para crear una lista de todos los cursos repetidos como cursos
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code) {

    List <Course> repeatedCourses = List <Course> ();
    coursesListSnapshot.forEach((c){

      /**String guaco = c.data["members"].toString();

      String guacote1 = guaco.replaceAll(RegExp(r"\["), "");
      String guacote = guacote1.replaceAll(RegExp(r"\]"), "");

      List <String> guaquito = guacote.split(", ");**/

      if (c.data["code"] == code){

        List <String> ifNull = [];
        List<dynamic> superList = c.data["members"] ?? ifNull;
        List<String> subList = List <String>.from(superList.whereType<String>()) ?? ifNull;

        Course course = Course (code: c.data["code"], creationDate: c.data["creationDate"],
            thematic: c.data["thematic"],name: c.data["name"], institution: c.data["institution"],
            courseOwner: c.data["userOwner"], id: c.data["id"], members: subList);

        repeatedCourses.add(course);
      }

    });

    return repeatedCourses;

    }

    List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot) {

      List <CourseCard> courses = List <CourseCard> ();

      coursesListSnapshot.forEach(
            (c) {

              List <String> ifNull = [];
              List<dynamic> superList = c.data["members"] ?? ifNull;
              List<String> subList = List <String>.from(superList.whereType<String>()) ?? ifNull;

              CourseCard courseCard = CourseCard(
                course: Course (code: c.data["code"], institution: c.data["institution"], name: c.data["name"],
                    creationDate: c.data["creationDate"], courseOwner: c.data["courseOwner"],
                    thematic: c.data["thematic"], id: c.data["id"], members: subList)
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