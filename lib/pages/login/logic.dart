import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_demo_app/app_routes.dart';
import 'package:my_demo_app/core/database/sql_manager.dart';
import 'package:my_demo_app/main.dart';
import 'package:my_demo_app/utils/util_object.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/database/provider/user_table_provider.dart';

class LoginLogic extends GetxController {
  String phoneNumber='';
  String password='';
  doLogin()async{
    UserTableProvider u=UserTableProvider();
    u.getDatabase();
    var res=await u.getAllUsers();
    print(res);
    var res2=await u.getUserByPhoneNumberAndPassword(phoneNumber, password);
    print(res2);
    if(res2['id']!=null){
      box.write('account', res2);
      print('登陆成功');
      Get.offAllNamed(Routes.HOME);
      Fluttertoast.showToast(msg: '登陆成功');
    }else{
      Fluttertoast.showToast(msg: '账号或密码错误');
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() async{
    print(await getDatabasesPath());
    // TODO: implement onReady
    super.onReady();
  }

}
