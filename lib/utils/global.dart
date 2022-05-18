import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wandemo/controller/login_controller.dart';
import 'package:wandemo/http/dio_manager.dart';
import 'package:sp_util/sp_util.dart';

import '../model/login_info_model.dart';
import 'constant.dart';
class Global{
  static LoginInfoModel? loginInfoModel;

  static Future init() async{
    Get.put<LoginController>(LoginController());//初始化loginController 控制器
    await DioManager().initCookieJar();
    await SpUtil.getInstance();
    Map? data = SpUtil.getObject(KEY_USER);
    if(data != null){
      loginInfoModel = LoginInfoModel.fromJson(data);
      appState.setLoginState(loginInfoModel != null?LoginState.LOGIN:LoginState.LOGIN_OUT);
    }

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
}