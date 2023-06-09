import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/userModel.dart';

class DbHelper {
  Database? _db;

  static final DbHelper instance = DbHelper._internal();

  factory DbHelper() {
    return instance;
  }
  DbHelper._internal();

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT "
        ")");
  }

  Future<int?> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.insert(Table_User, user.toMap());
    print(res);
    print("3");
    return res;
  }

  Future<UserModel?> getLoginUser(String c_Email, String password) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$c_Email' AND "
        "$C_Password = '$password'");

    if (res!.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  Future<int?> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [C_UserID]);
    return res;
  }

  Future<int?> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        ?.delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }
}
