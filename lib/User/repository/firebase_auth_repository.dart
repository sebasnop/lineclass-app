import 'package:firebase_auth/firebase_auth.dart';
import 'package:lineclass/User/repository/firebase_auth_api.dart';

class FirebaseAuthRepository {

  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInWithGoogle () => _firebaseAuthAPI.signInWithGoogle();

  signOut() => _firebaseAuthAPI.signOut();

}