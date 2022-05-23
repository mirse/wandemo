import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum LoginState{LOGIN,LOGIN_OUT}

class AppController extends GetxController {
  var _loginState = LoginState.LOGIN_OUT.obs;
  var _iconPath = ''.obs;

  //用户是否已经登录了
  bool get isLogin =>_loginState.value==LoginState.LOGIN;

  void setLoginState(loginState){
    _loginState.value = loginState;
  }

  Rx<LoginState> get loginState => _loginState;

  void setIconPath(iconPath){
    _iconPath.value = iconPath;
  }

  String get mIconPath => _iconPath.value;

}

AppController get appController => Get.find<AppController>();