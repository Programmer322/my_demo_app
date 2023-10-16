import 'package:get/get.dart';

import 'logic.dart';

class SharePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SharePageLogic());
  }
}
