import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

import 'package:crypto/crypto.dart';
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
  static const int Version = 2;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';
  static const String C_Salt = 'salt';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(
      path,
      version: Version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    _db = db;
    return db;
  }

  Future<void> _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " $C_Salt TEXT "
        ")");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("DROP TABLE IF EXISTS $Table_User");
      await _onCreate(db, newVersion);
    }
  }

  String _generateSalt() {
    final random = Random.secure();
    final values = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(values);
  }

  String hashPassword(String password, String salt) {
    final bytes = utf8.encode('$salt$password');
    return sha256.convert(bytes).toString();
  }

  Future<int?> saveData(UserModel user) async {
    var dbClient = await db;
    final salt = _generateSalt();
    final hashed = hashPassword(user.password ?? '', salt);
    final map = <String, dynamic>{
      C_UserName: user.user_name,
      C_Email: user.email,
      C_Password: hashed,
      C_Salt: salt,
    };
    return await dbClient?.insert(Table_User, map);
  }

  Future<UserModel?> getLoginUser(String email, String password) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery(
      "SELECT * FROM $Table_User WHERE $C_Email = ?",
      [email],
    );

    if (res == null || res.isEmpty) {
      return null;
    }

    final row = res.first;
    final salt = row[C_Salt] as String? ?? '';
    final storedHash = row[C_Password] as String? ?? '';
    final inputHash = hashPassword(password, salt);

    if (inputHash != storedHash) {
      return null;
    }

    return UserModel.fromMap(row);
  }
}
