import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:wandemo/notifier/setting_notifier.dart';
import '../controller/setting_controller.dart';
import '../generated/l10n.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              S
                  .of(context)
                  .setting
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                //todo Get.theme.cardColor 不能实现马上更新
                  color: Theme
                      .of(context)
                      .cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Consumer<SettingNotifier>(builder: (BuildContext context, notifier, Widget? child) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        S.of(context).darkMode,
                        style: Get.textTheme.bodyText1,
                      ),
                      trailing: Switch(
                        onChanged: (bool value) {
                          notifier.switchTheme(value);
                        },
                        value: notifier.mSwitch,
                      ),
                    ),
                    Divider(),
                    Container(
                        child: Column(children: [
                          ListTile(
                            title: Text(
                              S
                                  .of(context)
                                  .globalization,
                              style: Get.textTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              S
                                  .of(context)
                                  .chinese,
                              style: Get.textTheme.bodyText1,
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 40, right: 10),
                            trailing: Radio(
                              value: 0,
                              groupValue: notifier.mRadioSelect,
                              onChanged: (value) {
                                notifier.radioValueChange(value);
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              S
                                  .of(context)
                                  .english,
                              style: Get.textTheme.bodyText1,
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 40, right: 10),
                            trailing: Radio(
                              value: 1,
                              groupValue: Provider.of<SettingNotifier>(context,listen: true).mRadioSelect,
                              onChanged: (value) {
                                Provider.of<SettingNotifier>(context,listen: false).radioValueChange(value);
                              },
                            ),
                          ),
                        ])),
                    Divider(),
                  ],
                );
              },

              ),),
          ],
        )
    );
  }
}



