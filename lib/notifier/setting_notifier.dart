
import 'package:flutter/cupertino.dart';


import '../utils/app_theme.dart';
import '../utils/global.dart';


class SettingNotifier extends ChangeNotifier{

  var _radioSelect = Global.getLanguage() == 0?0:1;
  var _theme = Global.getIfLightTheme() == true?lightTheme:darkTheme;
  Locale _locale = Global.getLanguage() == 0?Locale('zh','CN'):Locale("en", "US");

  get mSwitch => _theme != lightTheme;
  get mRadioSelect => _radioSelect;
  get local => _locale;
  get theme => _theme;

  void switchTheme(bool mSwitch){
    _theme = mSwitch?darkTheme:lightTheme;
    print('$_theme');
    Global.saveIfLightTheme(!mSwitch);
    notifyListeners();
  }

  void radioValueChange(var value){
    _radioSelect = value;
    if(value == 0){
      _locale = Locale("zh", "CN");
      Global.saveLanguage(0);
      print('radioValueChange zh');
    }
    else if(value == 1){
      _locale = Locale("en", "US");
      Global.saveLanguage(1);
      print('radioValueChange en');
    }
    notifyListeners();
  }
}