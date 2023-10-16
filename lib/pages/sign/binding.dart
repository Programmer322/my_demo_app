import 'package:get/get.dart';

import 'logic.dart';

class SignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignLogic());
  }
}
