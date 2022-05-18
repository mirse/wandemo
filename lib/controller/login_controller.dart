

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum LoginState{ LOGIN , LOGIN_OUT }

class LoginController extends GetxController {
  var _loginState = LoginState.LOGIN_OUT.obs;
  void setLoginState(loginState){
    _loginState.value = loginState;
  }

  //用户是否已经登录了
  bool get isLogin =>_loginState.value==LoginState.LOGIN;
}

LoginController get appState => Get.find<LoginController>();