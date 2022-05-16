import 'package:get/get.dart';

enum LoginState{ LOGIN , LOGIN_OUT }

class LoginController extends GetxController {
  var _loginState = LoginState.LOGIN_OUT.obs;
  void setLoginState(loginState){
    _loginState = loginState;
  }

  //用户是否已经登录了
  bool get isLogin =>_loginState.value==LoginState.LOGIN;
}

LoginController get appState => Get.find<LoginController>();