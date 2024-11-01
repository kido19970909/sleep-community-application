import 'package:get/instance_manager.dart';
import 'package:sleep_app/pages/main_page/main_page_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
  }
}
