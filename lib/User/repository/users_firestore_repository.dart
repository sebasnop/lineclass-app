import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/repository/users_firestore_api.dart';

class UsersFirestoreRepository {

  final _usersFirestoreAPI = UsersFirestoreAPI();

  void updateUserData (User user) => _usersFirestoreAPI.updateUserData(user);

  User buildUser (DocumentSnapshot userSnapshot) => _usersFirestoreAPI.buildUser(userSnapshot);

  //Stream <DocumentSnapshot> getUser (User user) =>  _usersFirestoreAPI.getUser(user);

}