import 'package:get/get.dart';
import 'package:greengrocer/src/pages/base/controllerr/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
