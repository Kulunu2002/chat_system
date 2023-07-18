import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSetup {
  static String _DBName = 'my_db.db';

  Future setUpDB() async {
    var db = await openDatabase(_DBName);
    await db.close();
    print(db);
  }

  void createUserTable() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DBName);

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE User(id INTEGER PRIMARY KEY, email TEXT, password TEXT , name TEXT)');
          await db.execute(
          'CREATE TABLE Chat(chatid INTEGER PRIMARY KEY, user1id TEXT, user2id TEXT , messages TEXT,   sender TEXT)');
    });
  }


  Future<Database> getDatabaseInstance() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DBName);

    // open the database
    Database database = await openDatabase(path, version: 1);
    return database;
  }
}
