import 'package:wandemo/http/dio_manager.dart';
import 'package:sp_util/sp_util.dart';

import '../model/login_info_model.dart';
import 'constant.dart';
class Global{
  static LoginInfoModel? loginInfoModel;

  static Future init() async{
    await DioManager().initCookieJar();
    await SpUtil.getInstance();
    loginInfoModel = SpUtil.getObject(KEY_USER) as LoginInfoModel;
  }

  static saveUserInfo(LoginInfoModel loginInfo){
    SpUtil.putObject(KEY_USER, loginInfo);
    loginInfoModel = loginInfo;
  }

  static bool getLoginState(){
    return loginInfoModel != null;
  }
}