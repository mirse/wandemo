import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wandemo/controller/app_controller.dart';

import '../http/http_manager.dart';
import '../utils/global.dart';
import '../utils/toast_utils.dart';
import '../widget/dialog_widget.dart';
import 'package:dio/dio.dart' as dio;

class LoginController extends GetxController {
  var _isObscure = false.obs;
  var _isLoginBtnEnable = false.obs;

  String _userNameCache = '';
  String _pwdCache = '';

  //登录按钮是否可用
  bool get isLoginBtnEnable =>_isLoginBtnEnable.value;

  //密码栏是否可见
  bool get isObscure =>_isObscure.value;

  //用户名
  set setUserNameCache(userName){
    _userNameCache = userName;
    print('userName:${userName},${_userNameCache == null}');
    _isLoginBtnEnable.value = ((_userNameCache.isNotEmpty) && (_pwdCache.isNotEmpty));
  }

  //密码
  set setPwdCache(pwd){
    _pwdCache = pwd;
    _isLoginBtnEnable.value = ((_userNameCache.isNotEmpty) && (_pwdCache.isNotEmpty));
  }

  //是否可见
  set setObscure(isObscure){
    _isObscure.value = isObscure;
  }

  //登录
  void login(){
    LoadingDialog.show();
    HttpManager().login(
        data: dio.FormData.fromMap(
          {'username':_userNameCache,'password':_pwdCache},
        ),
        success: (data){
          Global.saveUserInfo(data);
          appController.setLoginState(LoginState.LOGIN);
          LoadingDialog.dismiss();
          ToastUtils.showToast('登录成功');
          Get.back();
        },fail:(errorCode,msg){
      print('登录失败:${errorCode},${msg}');
      LoadingDialog.dismiss();
      ToastUtils.showToast('登录失败：${msg}');
    }
    );
  }

  @override
  void onClose() {
    //Get.lazyPut才会onClose()
    print('onClose');
  }

  @override
  void onReady() {
    print('onReady');
  }

  @override
  void onInit() {
    print('onInit');
  }
}