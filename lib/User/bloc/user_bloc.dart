import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/model/course.dart';
import 'package:lineclass/Course/ui/widgets/course_card.dart';
import 'package:lineclass/Course/repository/courses_firestore_api.dart';
import 'package:lineclass/Course/repository/courses_firestore_repository.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/repository/firebase_auth_repository.dart';
import 'package:lineclass/User/repository/users_firestore_repository.dart';

class UserBloc implements Bloc {



  /// CASOS DE USO DE FIREBASE AUTH

  final _firebaseAuthRepository = FirebaseAuthRepository();

    /// Iniciar Sesión con Google

  Future<FirebaseUser> signIn() => _firebaseAuthRepository.signIn();

    /// Cerrar Sesión de Google

  signOut() => _firebaseAuthRepository.signOut();

    /// Obtener información de cambios en la sesión

  Stream <FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream <FirebaseUser> get authStatus => streamFirebase;

    /// Obtener información del usuario actual

  Future <FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();



  /// CASOS DE USO DE FIRESTORE USUARIOS

  final _usersFirestoreRepository = UsersFirestoreRepository();

  void updateUserData (User user) => _usersFirestoreRepository.updateUserData(user);


  /// CASOS DE USO DE FIRESTORE CURSOS

  final _coursesFirestoreRepository = CoursesFirestoreRepository();

    /// Instancia de cursos

    // Crear curso
  Future <void> createCourse (Course course) => _coursesFirestoreRepository.createCourse(course);

  // Actualizar miembros de un curso
  void updateCourseMembers (Course course) => _coursesFirestoreRepository.updateCourseMembers(course);

    // Traer todos los cursos
  Future <List> allCourses () => _coursesFirestoreRepository.allCourses();

    // Instanciar una lista de cursos con el mismo código para saber si está repetido
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code)
  => _coursesFirestoreRepository.repeatedListCourses(coursesListSnapshot, code);

              ///List <Course> listCourses (List<DocumentSnapshot> coursesListSnapshot)
              ///=> _cloudFirestoreRepository.listCourses(coursesListSnapshot);

    /// Vista de cursos

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