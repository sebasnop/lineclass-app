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
  Future<FirebaseUser> signIn() => _firebaseAuthRepository.signInWithGoogle();

    /// Cerrar Sesión de Google
  signOut() => _firebaseAuthRepository.signOut();

    /// Obtener información de cambios en la sesión
  Stream <FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream <FirebaseUser> get authStatus => streamFirebase;

    /// Obtener información del usuario actual
  Future <FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();



  /// CASOS DE USO DE FIRESTORE USUARIOS

  final _usersFirestoreRepository = UsersFirestoreRepository();

    ///Actualizar datos del usuario
  void updateUserData (User user) => _usersFirestoreRepository.updateUserData(user);

    ///Traer en tiempo real un snapshot del document del usuario
  Stream <DocumentSnapshot> getUser (String userUid) => _usersFirestoreRepository.getUser(userUid);

    /// Crear un objeto User a partir de un snapshot del document usuario
  User buildUser (DocumentSnapshot userSnapshot) => _usersFirestoreRepository.buildUser(userSnapshot);

    ///Traer la referencia del document del usuario
  DocumentReference getUserReference (String userUid) => _usersFirestoreRepository.getUserReference(userUid);

    /// Crear un objeto User a partir de una referencia del document usuario
  Future <User> getUserByReference (DocumentReference userReference) => _usersFirestoreRepository.getUserByReference(userReference);



  /// CASOS DE USO DE FIRESTORE CURSOS

  final _coursesFirestoreRepository = CoursesFirestoreRepository();

      /// Crear curso
  Future <void> createCourse (Course course) => _coursesFirestoreRepository.createCourse(course);

      /// Actualizar miembros de un curso
  void updateCourseMembers (Course course) => _coursesFirestoreRepository.updateCourseMembers(course);

      /// Traer todos los cursos como una lista de snapshots de documents
  Future <List> ownCourses (DocumentReference userReference) => _coursesFirestoreRepository.ownCourses(userReference);

      /// Instanciar una lista de cursos con el mismo código para saber si está repetido
  List <Course> repeatedListCourses (List<DocumentSnapshot> coursesListSnapshot, String code)
  => _coursesFirestoreRepository.repeatedListCourses(coursesListSnapshot, code);

  Future <List> allCourses () => _coursesFirestoreRepository.allCourses();

  ///  VISTA

    /// Traer todos los cursos en tiempo real como snapshots
  Stream<QuerySnapshot> coursesListStream = Firestore.instance.collection(CoursesFirestoreAPI().courses).snapshots();

  Stream<QuerySnapshot> yourCoursesListStream (DocumentReference userReference) {

    //Stream <QuerySnapshot> studentCourses = Firestore.instance.collection(CoursesFirestoreAPI().courses).where("members", arrayContains: userReference ).snapshots();
    Stream <QuerySnapshot> teacherCourses = Firestore.instance.collection(CoursesFirestoreAPI().courses).where("courseOwner", isEqualTo: userReference).snapshots();

    return teacherCourses;
  }

    /// Construir cada card de los cursos que sean
  List <CourseCard> buildCourses(List<DocumentSnapshot> coursesListSnapshot)
  => _coursesFirestoreRepository.buildCourses(coursesListSnapshot);




  @override
  void dispose() {
    // TODO: implement dispose
  }

}