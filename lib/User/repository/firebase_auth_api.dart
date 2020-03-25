import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signIn () async {
    await signOut();

    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    AuthResult authResult = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(idToken: gSA.idToken, accessToken: gSA.accessToken)
    );

    FirebaseUser user = await authResult.user;

    return user;

  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      AuthResult result = await _auth.signInWithCredential(credential);
      return result?.user;
    }
    return null;
  }

  signOut () async {
    await _auth.signOut().then((onValue) => print("Sesión cerrada Firebase"));
    _googleSignIn.signOut().then((onValue) => print("Sesión cerrada Google"));
  }

}