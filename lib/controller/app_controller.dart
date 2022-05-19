import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum LoginState{LOGIN,LOGIN_OUT}

class AppController extends GetxController {
  var _loginState = LoginState.LOGIN_OUT.obs;

  //用户是否已经登录了
  bool get isLogin =>_loginState.value==LoginState.LOGIN;

  void setLoginState(loginState){
    _loginState.value = loginState;
  }

  Rx<LoginState> get loginState => _loginState;

}

AppController get appController => Get.find<AppController>();