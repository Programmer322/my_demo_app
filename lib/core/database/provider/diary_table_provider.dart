import 'package:my_demo_app/core/database/provider/base_table_provider.dart';
import 'package:my_demo_app/model/diary.dart';
import 'package:sqflite/sqflite.dart';

class DiaryTableProvider extends BaseTableProvider {
  final String tableDiaryName = "diary";
  final String cloumnId = "id";
  final String userid = "user_id";
  final String content = "content";
  final String pubTime = 'pub_time';
  final String imagePath = 'image_path';
  final String title = 'title';
  final String videoPath = 'video_path';

  @override
  String tableName() {
    return tableDiaryName;
  }

  @override
  String createTableString() {
    return '''CREATE TABLE $tableDiaryName (
    $cloumnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $userid INTEGER NOT NULL,
    $content TEXT NOT NULL,
    $pubTime DATETIME NOT NULL,
    $imagePath TEXT,
    $title TEXT NOT NULL,
    $videoPath TEXT);''';
  }
  Future<void> insertDiary(Diary diary) async {
    final Database db = await getDatabase();
    await db.insert(
      tableName(),
      diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Map<String, dynamic>>> getAllDiaries() async {
    final Database db = await getDatabase();
    return db.query(tableName());
  }
  Future<List<Diary>> getDiariesByUserId(int userId) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> results = await db.query(
      tableName(),
      where: '$userid = ?',
      whereArgs: [userId],
    );

    List<Diary> diaries = results.map((diaryMap) => Diary.fromMap(diaryMap)).toList();
    return diaries;
  }
  Future<void> updateDiary(Diary updatedDiary) async {
    final Database db = await getDatabase();
    await db.update(
      tableName(),
      updatedDiary.toMap(),
      where: '$cloumnId = ?',
      whereArgs: [updatedDiary.id],
    );
  }
  Future<void> deleteDiary(int diaryId) async {
    final Database db = await getDatabase();
    await db.delete(
      tableName(),
      where: '$cloumnId = ?',
      whereArgs: [diaryId],
    );
  }
}
