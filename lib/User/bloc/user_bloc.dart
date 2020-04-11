import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:lineclass/Course/bloc/course_bloc.dart';
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

  @override
  void dispose() {
    // TODO: implement dispose
  }

}