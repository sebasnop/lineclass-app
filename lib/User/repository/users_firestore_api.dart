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
    String firstLastName = nameParts[1] ?? "";
    String secondLastName = nameParts[2] ?? "";

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
      "firstLastName": firstLastName,
      "secondLastName": secondLastName,
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
      name: userSnapshot.data["name"],
      email: userSnapshot.data["email"],
      photoUrl: userSnapshot.data["photoUrl"],
      firstName: userSnapshot.data["firstName"],
      firstLastName: userSnapshot.data["firstLastName"],
      secondLastName: userSnapshot.data["secondLastName"],
      nickname: userSnapshot.data["nickname"],
      lastSignIn: userSnapshot.data["lastSignIn"],
    );


    return user;

  }

    /// Traer el usuario en tiempo real como snapshots
  Stream <DocumentSnapshot> getUser (String userUid) {
    Stream <DocumentSnapshot> userSnapshot;
    Stream <DocumentSnapshot> documentSnapshot = _db.collection("users").document(userUid).snapshots();
    userSnapshot = documentSnapshot;
    return userSnapshot;
  }

    ///Traer la referencia del document del usuario
  DocumentReference getUserReference (String userUid) {
    DocumentReference userReference;
    DocumentReference ref = _db.collection("users").document(userUid);
    userReference = ref;
    return userReference;
  }

  Future <User> getUserByReference (DocumentReference userReference){

    Future <User> userByFuture = userReference.get().then((snapshot) {

      User user = buildUser(snapshot);

      return user;

    });

    return userByFuture;

  }

}