import 'package:lineclass/User/model/user.dart';
import 'package:lineclass/User/repository/users_firestore_api.dart';

class UsersFirestoreRepository {

  final _usersFirestoreAPI = UsersFirestoreAPI();

  void updateUserData (User user) => _usersFirestoreAPI.updateUserData(user);

}