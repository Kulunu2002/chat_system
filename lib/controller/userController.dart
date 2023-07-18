import 'package:assignment_2/screens/dashBoardPage.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../services/userDAO.dart';

class UserController extends GetxController {
  var userList = <UserModel>[].obs;
  var userM = UserModel().obs;

  void insertUser({String? email, String? password, String? name}) async {
    // Create data model object
    UserModel userModel =
        UserModel(email: email, password: password, name: name);

    // Create DAO object
    UserDAO userDAO = UserDAO();
    int id = await userDAO.insertUser(userModel);
    userModel.id = id;
    userList.add(userModel);
  }

  void readUser() async {
    UserDAO userDAO = UserDAO();
    List<Map> result = await userDAO.readUser();
    for (Map user in result) {
      UserModel userModel =
          UserModel(email: user["email"], name: user["name"], id: user["id"]);

      if (userModel.id != userM.value.id) {
        userList.add(userModel);
      }
      print(userList);
    }
  }

  Future<bool> readUserEandP({String? email, String? password}) async {
    UserModel userModel =
        UserModel(email: email ?? "", password: password ?? "");

    UserModel? output =
        await UserDAO().readUserEandP(userModel.email!, userModel.password!);
    if (output == null) {
      return false;
    } else {
      print("User found.");
    }
    userM.value = output;

    return true;
  }

  Future<bool> updateName(String? newName) async {
  int id = userM.value.id!;
  UserModel userModel = UserModel(name: newName, id: id);

  bool success = await UserDAO().updateName(id: userModel.id, name: userModel.name);
  if (success) {
    userM.value = userModel;
    return true;
  } else {
    return false;
  }
}

}
