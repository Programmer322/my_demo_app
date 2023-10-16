import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_demo_app/app.dart';
import 'package:my_demo_app/core/database/provider/diary_table_provider.dart';
import 'package:my_demo_app/core/database/provider/user_table_provider.dart';

import 'core/database/provider/todo_list_table.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  _createTables();
  runApp(createApp());
}
GetStorage box=GetStorage();

void _createTables() async {
  UserTableProvider userTableProvider = UserTableProvider();
  DiaryTableProvider diaryTableProvider = DiaryTableProvider();
  TodoListTableProvider todoListTableProvider=TodoListTableProvider();
  await userTableProvider.createTable();
  await diaryTableProvider.createTable();
  await todoListTableProvider.createTable();
}
