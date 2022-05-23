import 'package:get/get.dart';
import 'package:wandemo/controller/project_controller.dart';


class ProjectBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectController());
  }
}