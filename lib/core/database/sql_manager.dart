import 'package:sqflite/sqflite.dart';

import '../../utils/util_object.dart';

class SqlManager{
  static const _version=1;
  static const _dbName='root.db';
  static Database? _database;
  static Future<void> init()async{
    String dbPath=await getDatabasesPath()+"/$_dbName";
    _database=await openDatabase(dbPath,version: _version,onCreate: (db,version){});
  }
  static Future<Database> getCurrentDatabase()async{
    if(_database==null){
     await init();
    }
    return _database!;
  }
  static Future<bool> isTableExists(String tableName)async{
    await getCurrentDatabase();
    var res =await _database?.rawQuery(
      "select * from sqlite_master where type='table' and name='$tableName'"
    );
    return !ObjectUtil.isEmptyList(res);
  }
  static void close(){
    _database?.close();
    _database=null;
  }
}