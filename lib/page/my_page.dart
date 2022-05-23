import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wandemo/utils/toast_utils.dart';

import '../controller/app_controller.dart';
import '../utils/global.dart';

class MyPage extends GetView<AppController> {
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(
        child: Column(
          children: [
            _headerWidget(context),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .shadowColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('collect'.tr, style: Get.textTheme.bodyText1,),
                    leading: Image.asset(
                      'assets/imgs/ic_zan.png', width: 30, height: 30,),),
                  Divider(),
                  ListTile(title: Text('rank'.tr, style: Get.textTheme.bodyText1),
                    leading: Image.asset(
                      'assets/imgs/ic_rank.png', width: 30, height: 30,),),
                  Divider(),
                  ListTile(
                    title: Text('setting'.tr, style: Get.textTheme.bodyText1),
                    leading: Image.asset(
                      'assets/imgs/ic_setting.png', width: 30, height: 30,),
                    onTap: () => Get.toNamed('/setting'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('about'.tr, style: Get.textTheme.bodyText1),
                    leading: Image.asset(
                      'assets/imgs/ic_about.png', width: 30, height: 30,),),

                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _headerWidget(context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 200,
      width: double.infinity,
      //color: Colors.blueAccent,
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .shadowColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: appController.mIconPath.isEmpty?Image.asset(
                'assets/imgs/default_avatar.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ):
              Image.file(
                File(appController.mIconPath),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),

            ),
            SizedBox(height: 20,),
            Text(
              appController.isLogin
                  ? (Global.loginInfoModel == null
                  ? 'admin'
                  : Global.loginInfoModel!.nickname)
                  : 'admin',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1,
            ),
          ],
        ),
        onTap: () {
          _setUserIcon(context);
        },
      ),
    );
  }

  void _setUserIcon(context) {
    if (appController.isLogin) {
      Get.bottomSheet(
        Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                title: Text("拍照", style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
                onTap: () {
                  _takePhoto();
                },
              ),
              Divider(),
              ListTile(
                title: Text("选择图片", style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
                onTap: () {
                  _selectPhoto();
                },
              ),
              Divider(),
              ListTile(
                title: Text("取消", style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
                onTap: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
      );
    }
    else {
      ToastUtils.showMyToast('login_first'.tr);
    }
  }

  Future _selectPhoto() async {
    final pickedFile = await picker.pickImage(
      // 拍照获取图片
      // source: ImageSource.camera,
      // 手机选择图库
        source: ImageSource.gallery,
        // 图片的最大宽度
        maxWidth: 400
    );
    var path = pickedFile?.path;
    if(path != null){
      Global.saveIconPath(path);
      appController.setIconPath(path);
    }
    Get.back();
  }

  Future _takePhoto() async {
    final pickedFile = await picker.pickImage(
      // 拍照获取图片
      // source: ImageSource.camera,
      // 手机选择图库
        source: ImageSource.camera,
        // 图片的最大宽度
        maxWidth: 400
    );
    var path = pickedFile?.path;
    if(path != null){
      Global.saveIconPath(path);
      appController.setIconPath(path);
    }
    Get.back();
  }
}