import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wandemo/controller/app_controller.dart';
import 'package:wandemo/controller/login_controller.dart';
import 'package:wandemo/http/dio_manager.dart';
import 'package:sp_util/sp_util.dart';

import '../model/login_info_model.dart';
import 'constant.dart';
class Global{
  static LoginInfoModel? loginInfoModel;

  static Future init() async{
    Get.put<AppController>(AppController());//初始化loginController 控制器
    await DioManager().initCookieJar();
    await SpUtil.getInstance();
    Map? data = SpUtil.getObject(KEY_USER);
    if(data != null){
      loginInfoModel = LoginInfoModel.fromJson(data);
      appController.setLoginState(loginInfoModel != null?LoginState.LOGIN:LoginState.LOGIN_OUT);
    }

    String? iconPath = SpUtil.getString(KEY_ICON_PATH);
    appController.setIconPath(iconPath);
  }

  static saveUserInfo(LoginInfoModel loginInfo){
    SpUtil.putObject(KEY_USER, loginInfo);
    loginInfoModel = loginInfo;
  }

  static clearUserInfo(){
    SpUtil.remove(KEY_USER);
    loginInfoModel = null;
  }

  static bool getLoginState(){
    return loginInfoModel != null;
  }

  static saveLanguage(int value){
    SpUtil.putInt(KEY_LANGUAGE, value);
  }

  static int? getLanguage(){
    var value = SpUtil.getInt(KEY_LANGUAGE,defValue: 0);
    return value;
  }

  static saveIfLightTheme(bool isLightTheme){
    SpUtil.putBool(KEY_THEME, isLightTheme);
  }

  static bool? getIfLightTheme(){
    var isLightTheme = SpUtil.getBool(KEY_THEME,defValue: true);
    return isLightTheme;
  }

  static saveIconPath(String path){
    SpUtil.putString(KEY_ICON_PATH, path);
  }

  static String? getIconPath(){
    var path = SpUtil.getString(KEY_ICON_PATH,defValue: '');
    return path;
  }
}