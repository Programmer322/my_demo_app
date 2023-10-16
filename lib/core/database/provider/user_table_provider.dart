import 'package:my_demo_app/core/database/provider/base_table_provider.dart';
import 'package:my_demo_app/core/database/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/user.dart';

class UserTableProvider extends BaseTableProvider {
  final String tableUserName = "user";
  final String cloumnId = "id";
  final String userPhoneNumber = "phone_number";
  final String password = "password";
  final String signUpTime = 'sign_up_time';
  final String username = 'username';


  @override
  String tableName() {
    return tableUserName;
  }

  @override
  String createTableString() {
    return '''CREATE TABLE $tableUserName (
    $cloumnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $userPhoneNumber TEXT NOT NULL UNIQUE,
    $password TEXT NOT NULL,
    $signUpTime TEXT NOT NULL,
    $username TEXT);''';
  }
  Future<void> insertUser(Map<String,dynamic> userMap) async {
    final Database db = await getDatabase();
    await db.insert(
      tableName(),
      userMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('11111');
  }
  Future<Map<String,dynamic>> getUserByPhoneNumberAndPassword(
      String phoneNumber, String password) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> results = await db.query(
      tableName(),
      where: '$userPhoneNumber = ? AND password = ?',
      whereArgs: [phoneNumber, password],
    );

    if (results.isNotEmpty) {
      Map<String, dynamic> userMap = results.first;
      return userMap;
    } else {
      return {}; // 返回 null 表示未找到匹配的用户
    }
  }
  Future<void> updateUser(User updatedUser) async {
    final Database db = await getDatabase();
    await db.update(
      tableName(),
      updatedUser.toMap(),
      where: '$cloumnId = ?',
      whereArgs: [updatedUser.id],
    );
  }
  Future<void> deleteUser(int userId) async {
    final Database db = await getDatabase();
    await db.delete(
      tableName(),
      where: '$cloumnId = ?',
      whereArgs: [userId],
    );
  }
  Future<void> clearTable(Database db, String tableName) async {
    await db.execute('DELETE FROM $tableName;');
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final Database db = await getDatabase();
    return db.query(tableName());
  }
}
