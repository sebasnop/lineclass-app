import 'package:firebase_auth/firebase_auth.dart';
import 'package:lineclass/User/repository/firebase_auth_api.dart';

class FirebaseAuthRepository {

  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signIn () => _firebaseAuthAPI.signIn();

  signOut() => _firebaseAuthAPI.signOut();

}