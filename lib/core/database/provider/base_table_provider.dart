import 'package:my_demo_app/core/database/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseTableProvider {
  String tableName();
  String createTableString();

  Future<Database> getDatabase() async {
    bool isTableExist = await SqlManager.isTableExists(tableName());
    if (!isTableExist) {
      Database db = await SqlManager.getCurrentDatabase();
      await db.execute(createTableString());
      return db;
    } else {
      return SqlManager.getCurrentDatabase();
    }
  }

  Future<void> createTable() async {
    bool isTableExist = await SqlManager.isTableExists(tableName());
    if (!isTableExist) {
      Database db = await SqlManager.getCurrentDatabase();
      await db.execute(createTableString());
    }
  }
}
