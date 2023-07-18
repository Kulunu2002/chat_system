import 'package:get/get.dart';

import '../models/user.dart';
import '../utils/databaseSetup.dart';
import 'chatDAO.dart';

// Handle all CRUD operation of User Table
class UserDAO {
  var dbConnection;
  var userM = UserModel().obs;
  var userList = <UserModel>[].obs;

  // Insert a row
  Future<int> insertUser(UserModel userModel) async {
    int outputID = -1;

    // Insert some records in a transaction
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    await dbConnection.transaction((txn) async {
      outputID = await txn.rawInsert(
          'INSERT INTO User(email, password , name) VALUES("${userModel.email}", ${userModel.password}, "${userModel.name}")');
    });
    print('inserted1: $outputID');
    return outputID;
  }

  // Update a row

  Future<bool> updateName({int? id, String? name}) async {
    var dbConnection = await DatabaseSetup().getDatabaseInstance();
    int rowsAffected = await dbConnection.transaction((txn) async {
      return await txn.rawUpdate(
        'UPDATE User SET name = ? WHERE id = ?',
        [name, id],
      );
    });
    return true;
  }

  // Read all rows
  Future<List<Map>> readUser() async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM User');
    userList.addAll(list.map(
      (userModel) => UserModel(
        id: userModel['id'],
        email: userModel['email'],
        password: userModel['password'],
        name: userModel['name'],
      ),
    ));
    return list;
  }

  // Read a row
  Future<UserModel?> readUserEandP(String email, String password) async {
    dbConnection = await DatabaseSetup().getDatabaseInstance();
    List<Map<String, dynamic>> results = await dbConnection.query(
      'User',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      Map<String, dynamic> userModel = results.first;
      return UserModel(
        id: userModel['id'],
        email: userModel['email'],
        password: userModel['password'],
        name: userModel['name'],
      );
    }
    return userM.value = UserModel();
  }

  // Delete a row
}
