import 'package:get/get.dart';

import 'logic.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostLogic());
  }
}
