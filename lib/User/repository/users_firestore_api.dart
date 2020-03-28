import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/User/model/user.dart';

class UsersFirestoreAPI {

  final users = "users";
  final Firestore _db = Firestore.instance;

  /// Crear o actualizar usuario

  void updateUserData (User user) async {

    DocumentReference ref = _db.collection(users).document(user.uid);

    List <String> nameParts = user.name.split(" ");
    String firstName = nameParts[0];

    List <String> emailPartsOne = user.email.split("@");
    String firstNickname = emailPartsOne[0];

    List <String> emailPartsTwo = emailPartsOne[1].split(".");
    String emailProvider = emailPartsTwo[0];

    String nickname;

    if (emailProvider == "gmail") {
      nickname = firstNickname;
    } else {
      nickname = "$firstNickname$emailProvider";
    }

    return await ref.setData({
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "photoUrl": user.photoUrl,
      "firstName": firstName,
      "nickname": nickname,
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