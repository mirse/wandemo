import 'package:get/get.dart';
import 'package:wandemo/controller/home_controller.dart';
import 'package:wandemo/controller/setting_controller.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}