import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_theme.dart';
import '../utils/global.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _switch = false;
  int? _radioSelect = 0;

  void _radioValueChange(int? value){
    setState(() {
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
    });
  }


  @override
  void initState() {
    var value = Global.getLanguage();
    _radioSelect = value;
    var ifLightTheme = Global.getIfLightTheme();
    ifLightTheme == null ? _switch = false:_switch = !ifLightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr,),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            //todo Get.theme.cardColor 不能实现马上更新
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            ListTile(
              title: Text('darkMode'.tr,style: Get.textTheme.bodyText1,),
              trailing: Switch(
                onChanged: (bool value) {
                  setState(() {
                    _switch = !_switch;
                    print('${_switch}');
                    Get.changeTheme(_switch? darkTheme : lightTheme);
                    Global.saveIfLightTheme(!_switch);
                  });
                },
                value: _switch,

              ),
            ),
            Divider(),
            Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text('globalization'.tr,style: Get.textTheme.bodyText1,),
                  ),
                  ListTile(
                    title: Text('chinese'.tr,style: Get.textTheme.bodyText1,),
                    contentPadding: EdgeInsets.only(left: 40,right: 10),
                    trailing: Radio(
                        value: 0,
                        groupValue: _radioSelect,
                        onChanged: _radioValueChange,),
                  ),
                  ListTile(
                    title: Text('english'.tr,style: Get.textTheme.bodyText1,),
                    contentPadding: EdgeInsets.only(left: 40,right: 10),
                    trailing: Radio(
                      value: 1,
                      groupValue: _radioSelect,
                      onChanged: _radioValueChange,
                    ),
                  ),
                ]
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
