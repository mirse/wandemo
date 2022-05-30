
import 'package:provider/provider.dart';
import 'package:wandemo/http/dio_manager.dart';
import 'package:sp_util/sp_util.dart';
import 'package:wandemo/notifier/app_notifier.dart';

import '../model/login_info_model.dart';
import 'constant.dart';
class Global{
  static LoginInfoModel? loginInfoModel;
  static String? iconPath;

  static Future init() async{
    print('init start');
    await DioManager().initCookieJar();
    await SpUtil.getInstance();
    print('init all');
    Map? data = SpUtil.getObject(KEY_USER);
    if(data != null){
      loginInfoModel = LoginInfoModel.fromJson(data);
      //appNotifier.setLoginState(loginInfoModel != null?LoginState.LOGIN:LoginState.LOGIN_OUT);
    }
    iconPath = SpUtil.getString(KEY_ICON_PATH);
    //appNotifier.setIconPath(iconPath);
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

  static clearIconPath(){
    SpUtil.remove(KEY_ICON_PATH);
    iconPath = '';
  }

  static String? getIconPath(){
    var path = SpUtil.getString(KEY_ICON_PATH,defValue: '');
    return path;
  }
}