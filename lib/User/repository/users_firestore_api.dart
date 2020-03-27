import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/User/model/user.dart';

class UsersFirestoreAPI {

  final users = "users";
  final Firestore _db = Firestore.instance;

  /// Crear o actualizar usuario

  void updateUserData (User user) async {

    DocumentReference ref = _db.collection(users).document(user.uid);

    return await ref.setData({
      "uid": user.uid,
      "name": user.name,
      "firstName": user.name,
      "email": user.email,
      "photoUrl": user.photoUrl,
      "lastSignIn": Timestamp.now(),
      //"myCourses": user.myCourses,
    },
        merge: true
    );

  }

  User buildUser (DocumentSnapshot userSnapshot) {

    User user;

    user = User(
      uid: userSnapshot.data["uid"],
      firstName: userSnapshot.data["firstName"],
      lastSignIn: userSnapshot.data["lastSignIn"],
      name: userSnapshot.data["name"],
      email: userSnapshot.data["email"],
      photoUrl: userSnapshot.data["photoUrl"]
    );


    return user;

  }

}