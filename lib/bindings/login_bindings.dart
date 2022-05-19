import 'package:get/get.dart';
import 'package:wandemo/controller/login_controller.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}