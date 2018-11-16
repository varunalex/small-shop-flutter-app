import 'package:scoped_model/scoped_model.dart';

import './../models/user.dart';

class UsersModel extends Model {
  User _authenticatedUser;

  void login(String email, String password) {
    _authenticatedUser = User(id: 'userid', email: email, password: password);
  }
}
