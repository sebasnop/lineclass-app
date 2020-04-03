import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/User/bloc/user_bloc.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/repository/users_firestore_api.dart';

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
      'courseOwner': _db.document("$users/${course.courseOwner.uid}"),
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

  // Instanciar una Lista de Querys con todos los cursos que tienes como profesor como documentos
  Future <List> ownCourses (DocumentReference userReference) async {

    CollectionReference refOwnCourses = _db.collection(courses).where("courseOwner", isEqualTo: userReference);

    QuerySnapshot querySnapshot = await refOwnCourses.getDocuments();
    return querySnapshot.documents;

  }

  // Usar la lista de Querys para crear una lista de todos los cursos repetidos como cursos
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code) {

    List <Course> repeatedCourses = List <Course> ();
    coursesListSnapshot.forEach((c){

      if (c.data["code"] == code){

        List <String> ifNull = [];
        List<dynamic> superList = c.data["members"] ?? ifNull;
        List<String> subList = List <String>.from(superList.whereType<String>()) ?? ifNull;

        Course course = Course (code: c.data["code"]);

        /**, creationDate: c.data["creationDate"],
            thematic: c.data["thematic"],name: c.data["name"], institution: c.data["institution"],
            courseOwner: c.data["userOwner"], id: c.data["id"], members: subList);**/

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

    List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot) {

      List <CourseCard> courses = List <CourseCard> ();

      coursesListSnapshot.forEach(
            (c) {

              List <String> ifNull = [];
              List<dynamic> superList = c.data["members"] ?? ifNull;
              List<String> subList = List <String>.from(superList.whereType<String>()) ?? ifNull;

              // Convertir una referencia de Usuario en un objeto User
              DocumentReference userOwnerReference = c.data["courseOwner"];

              Stream <DocumentSnapshot> getUser (String userUid) {
                Stream <DocumentSnapshot> userSnapshot;
                Stream <DocumentSnapshot> ref = Firestore.instance.collection("users").document(userUid).snapshots();
                userSnapshot = ref;
                return userSnapshot;
              }

              Stream<DocumentSnapshot> getUserOwner = getUser(userOwnerReference.documentID);

              //User = getUserOwner.last;

              //Future <DocumentSnapshot> bro = ;

              //User courseOwner = UsersFirestoreAPI().buildUser(bro);

              CourseCard courseCard = CourseCard(
                course: Course (code: c.data["code"], institution: c.data["institution"], name: c.data["name"],
                    creationDate: c.data["creationDate"], courseOwner: User(name:"name",),//courseOwner: c.data["courseOwner"],
                    thematic: c.data["thematic"], id: c.data["id"], members: subList)
              );

              courses.add(courseCard);

            }
          );

      if (courses.isEmpty){
        CourseCard courseCard = CourseCard(
            course: Course (code: "", institution: "", name: "¡Bienvenido!",
                creationDate: Timestamp.now(), courseOwner: User(name:"Añade tu primer curso con el botón de \nabajo a la derecha <3"), thematic: "empty")
        );

            courses.add(courseCard);

      }

      return courses;

    }


  }