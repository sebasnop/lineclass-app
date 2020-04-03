import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/repository/users_firestore_api.dart';

class UsersFirestoreRepository {

  final _usersFirestoreAPI = UsersFirestoreAPI();

  void updateUserData (User user) => _usersFirestoreAPI.updateUserData(user);

  User buildUser (DocumentSnapshot userSnapshot) => _usersFirestoreAPI.buildUser(userSnapshot);

  Stream <DocumentSnapshot> getUser (String userUid) =>  _usersFirestoreAPI.getUser(userUid);

  DocumentReference getUserReference (String userUid) => _usersFirestoreAPI.getUserReference(userUid);

  Future <User> getUserByReference (DocumentReference userReference) => _usersFirestoreAPI.getUserByReference(userReference);

}