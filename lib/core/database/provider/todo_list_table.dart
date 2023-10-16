import 'package:my_demo_app/model/todo.dart';
import 'package:sqflite/sqflite.dart';

import 'base_table_provider.dart';

class TodoListTableProvider extends BaseTableProvider {
  final String tableTodoName = "Todo";
  final String cloumnId = "id";
  final String userid = "user_id";
  final String content = "content";
  final String pubTime = 'pub_time';
  final String imagePath = 'image_path';
  final String status = 'status';
  final String videoPath = 'video_path';

  @override
  String tableName() {
    return tableTodoName;
  }

  @override
  String createTableString() {
    return '''CREATE TABLE $tableTodoName (
    $cloumnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $userid INTEGER NOT NULL,
    $content TEXT NOT NULL,
    $pubTime DATETIME NOT NULL,
    $status TEXT NOT NULL);''';
  }
  Future<void> insertTodo(Todo todo) async {
    final Database db = await getDatabase();
    await db.insert(
      tableName(),
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> getTodoByUserId(int userId) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> results = await db.query(
      tableName(),
      where: '$userid = ?',
      whereArgs: [userId],
    );

    List<Todo> todoList = results.map((todoMap) => Todo.fromMap(todoMap)).toList();
    return todoList;
  }
  Future<void> updateTodo(Todo updatedTodo) async {
    final Database db = await getDatabase();
    await db.update(
      tableName(),
      updatedTodo.toMap(),
      where: '$cloumnId = ?',
      whereArgs: [updatedTodo.id],
    );
  }
  Future<void> deleteTodo(int TodoId) async {
    final Database db = await getDatabase();
    await db.delete(
      tableName(),
      where: '$cloumnId = ?',
      whereArgs: [TodoId],
    );
  }
}
