import 'package:get/get.dart';
import 'package:my_demo_app/main.dart';
import 'package:my_demo_app/pages/dairy/re_edit_diary/view.dart';
import 'package:my_demo_app/pages/home/binding.dart';
import 'package:my_demo_app/pages/home/view.dart';
import 'package:my_demo_app/pages/login/binding.dart';
import 'package:my_demo_app/pages/login/view.dart';
import 'package:my_demo_app/pages/post/edit_dairy/binding.dart';
import 'package:my_demo_app/pages/post/edit_dairy/view.dart';
import 'package:my_demo_app/pages/share_page/binding.dart';
import 'package:my_demo_app/pages/share_page/view.dart';
import 'package:my_demo_app/pages/sign/binding.dart';
import 'package:my_demo_app/pages/sign/view.dart';
import 'package:my_demo_app/pages/todo_list/binding.dart';
import 'package:my_demo_app/pages/todo_list/view.dart';
import 'package:my_demo_app/pages/user/binding.dart';
import 'package:my_demo_app/pages/user/logic.dart';
import 'package:my_demo_app/pages/user/view.dart';


abstract class AppPages{
  static final pages=[
    GetPage(name: Routes.LOGIN, page: ()=>LoginPage(),binding: LoginBinding()),
    GetPage(name: Routes.INIIAL, page: (){
      // box.erase();
      return box.hasData('account')?HomePage():LoginPage();
    }),
    GetPage(name: Routes.SIGNUP, page: ()=>SignPage(),binding: SignBinding()),
    GetPage(name: Routes.SHAREPAGE, page: ()=>SharePagePage(),binding: SharePageBinding()),
    GetPage(name: Routes.HOME, page: ()=>HomePage(),binding: HomeBinding()),
    GetPage(name: Routes.USER, page: ()=>UserPage(),binding: UserBinding()),
    GetPage(name: Routes.TODOLIST, page: ()=>TodoListPage(),binding: TodoListBinding()),
    GetPage(name: Routes.EDITDAIRY, page: ()=>EditDairyPage(),binding: EditDairyBinding()),
  ];
}

abstract class Routes{
  static const INIIAL = '/';
  static const USER = '/user';
  static const TODOLIST = '/todolist';
  static const LOGIN = '/login';
  static const SHAREPAGE = '/share';
  static const EDITDAIRY = '/edit_dairy';
  static const SIGNUP = '/sign_up';
  static const HOME = '/home';
}