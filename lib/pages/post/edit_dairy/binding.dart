import 'package:get/get.dart';

import 'logic.dart';

class EditDairyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditDairyLogic());
  }
}
