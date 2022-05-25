import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/setting_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build');
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
              GetBuilder<SettingController>(
                id: 'switchTheme',
                builder: (controller){
                  print('switchTheme');
                  return ListTile(
                    title: Text('darkMode'.tr,style: Get.textTheme.bodyText1,),
                    trailing: Switch(
                      onChanged: (bool value) {
                        controller.switchTheme(value);
                      },
                      value: controller.mSwitch,

                    ),
                  );
                },
              ),
              Divider(),
              GetBuilder<SettingController>(
                id: 'radioValueChange',
                builder: (controller){
                  print('radioValueChange');
                  return  Container(
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
                                groupValue: controller.mRadioSelect,
                                onChanged:(value){
                                  controller.radioValueChange(value);
                                },
                              ),
                            ),
                            ListTile(
                              title: Text('english'.tr,style: Get.textTheme.bodyText1,),
                              contentPadding: EdgeInsets.only(left: 40,right: 10),
                              trailing: Radio(
                                value: 1,
                                groupValue: controller.mRadioSelect,
                                onChanged:(value){
                                  controller.radioValueChange(value);
                                },
                              ),
                            ),
                          ]
                      )
                  );
                },
              ),
              Divider(),
            ],
          )
      ),
    );
  }
}
