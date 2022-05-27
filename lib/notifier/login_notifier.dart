
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../controller/app_controller.dart';
import '../generated/l10n.dart';
import '../http/http_manager.dart';
import '../utils/global.dart';
import '../utils/toast_utils.dart';
import '../widget/dialog_widget.dart';

class LoginNotifier extends ChangeNotifier{
  var _isObscure = true;
  var _isLoginBtnEnable = false;
  var ctx;

  String _userNameCache = '';
  String _pwdCache = '';

  //登录按钮是否可用
  bool get isLoginBtnEnable =>_isLoginBtnEnable;

  //密码栏是否可见
  bool get isObscure =>_isObscure;


  LoginNotifier(this.ctx);
  //用户名
  set setUserNameCache(userName){
    _userNameCache = userName;
    print('userName:${userName},${_userNameCache == null}');
    _isLoginBtnEnable = ((_userNameCache.isNotEmpty) && (_pwdCache.isNotEmpty));
    notifyListeners();
  }

  //密码
  set setPwdCache(pwd){
    _pwdCache = pwd;
    _isLoginBtnEnable = ((_userNameCache.isNotEmpty) && (_pwdCache.isNotEmpty));
    notifyListeners();
  }

  //是否可见
  set setObscure(isObscure){
    _isObscure = isObscure;
    notifyListeners();
  }

  //登录
  void login(){
    LoadingDialog.show(ctx);
    HttpManager().login(
        data: FormData.fromMap(
          {'username':_userNameCache,'password':_pwdCache},
        ),
        success: (data){
          Global.saveUserInfo(data);
          appController.setLoginState(LoginState.LOGIN);
          LoadingDialog.dismissDialog(ctx);
          ToastUtils.showMyToast(S.of(ctx).login_success);
          Navigator.pop(ctx);
        },fail:(errorCode,msg){

      LoadingDialog.dismissDialog(ctx);
      ToastUtils.showMyToast(S.of(ctx).login_fail+":"+msg);
    }
    );
  }
}