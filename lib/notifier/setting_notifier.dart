
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_theme.dart';
import '../utils/global.dart';


class SettingNotifier extends ChangeNotifier{
  var _switch = false;
  var _radioSelect = 0;

  get mSwitch => _switch;
  get mRadioSelect => _radioSelect;



  @override
  void onInit() {
    var value = Global.getLanguage();
    if(value != null){
      _radioSelect = value;
    }
    var ifLightTheme = Global.getIfLightTheme();
    ifLightTheme == null ? _switch = false:_switch = !ifLightTheme;
  }

  void switchTheme(bool mSwitch){
    _switch = mSwitch;
    Get.changeTheme(mSwitch? darkTheme : lightTheme);
    Global.saveIfLightTheme(!mSwitch);
    //update(['switchTheme']);
  }

  void radioValueChange(var value){
    _radioSelect = value;
    if(value == 0){
      var locale = Locale("zh", "CN");
      Get.updateLocale(locale);
      Global.saveLanguage(0);
    }
    else if(value == 1){
      var locale = Locale("en", "US");
      Get.updateLocale(locale);
      Global.saveLanguage(1);
    }
    //update(['radioValueChange']);
  }
}