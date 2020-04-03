import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

    /// Iniciar sesión con Google
  Future<FirebaseUser> signInWithGoogle () async {
    await signOut();

    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    AuthResult authResult = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken)
    );

    FirebaseUser user = authResult.user;

    return user;

  }

    /// Cerrar sesión de Google
  signOut () async {
    await _auth.signOut().then((onValue) => print("Sesión cerrada Firebase"));
    _googleSignIn.signOut().then((onValue) => print("Sesión cerrada Google"));
  }

}