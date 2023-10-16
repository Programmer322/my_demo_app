import 'package:get/get.dart';

import 'logic.dart';

class TodoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoListLogic());
  }
}
