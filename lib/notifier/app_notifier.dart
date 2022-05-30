
import 'package:flutter/cupertino.dart';

import '../utils/global.dart';

enum LoginState{LOGIN,LOGIN_OUT}

class AppNotifier extends ChangeNotifier{

  var _loginState = Global.loginInfoModel != null?LoginState.LOGIN:LoginState.LOGIN_OUT;
  var _iconPath = Global.iconPath;

  //用户是否已经登录了
  bool get isLogin =>_loginState==LoginState.LOGIN;

  void setLoginState(loginState){
    _loginState = loginState;
    notifyListeners();
  }

  get loginState => _loginState;

  void setIconPath(iconPath){
    _iconPath = iconPath;
    notifyListeners();
  }

  get mIconPath => _iconPath;

}