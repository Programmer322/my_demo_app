import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_demo_app/app.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/database/provider/user_table_provider.dart';
import '../../core/database/sql_manager.dart';

class SignLogic extends GetxController {
  String phoneNumber='';
  String password='';
  String username='';
  String dateTime='';
  late Database db;
  send() async {
  Map<String, dynamic> userMap = {
    'username': username,
    'phone_number': phoneNumber,
    'password': password,
    'sign_up_time': DateTime.now().toIso8601String(),
  };
  UserTableProvider userTableProvider= UserTableProvider();
  userTableProvider.getDatabase();
  await userTableProvider.insertUser(userMap);
Get.back();
appShowToast('注册成功');
}
  @override
  void onInit() {

    // TODO: implement onInit
    super.onInit();
  }
@override
  void onReady()async {
  // db=await SqlManager.getCurrentDatabase();

  // TODO: implement onReady
    super.onReady();
  }
}
