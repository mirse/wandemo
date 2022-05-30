import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wandemo/notifier/app_notifier.dart';
import 'package:wandemo/utils/toast_utils.dart';
import '../generated/l10n.dart';
import '../utils/global.dart';

class MyPage extends StatelessWidget {
  final picker = ImagePicker();
  late AppNotifier notifier;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<AppNotifier>(context,listen: true);
    return Scaffold(
        body: Column(
          children: [
            _headerWidget(context),
            Container(
              margin: EdgeInsets.only(left: 15.w, right: 15.w),
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .shadowColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(S
                        .of(context)
                        .collect, style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,),
                    leading: Image.asset(
                      'assets/imgs/ic_zan.png', width: 30.w, height: 30.w,),),
                  Divider(),
                  ListTile(title: Text(S
                      .of(context)
                      .rank, style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1),
                    leading: Image.asset(
                      'assets/imgs/ic_rank.png', width: 30.w, height: 30.w,),),
                  Divider(),
                  ListTile(
                    title: Text(S
                        .of(context)
                        .setting, style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1),
                    leading: Image.asset(
                      'assets/imgs/ic_setting.png', width: 30.w, height: 30.w,),
                    onTap: () => Navigator.pushNamed(context, '/setting'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(S
                        .of(context)
                        .about, style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1),
                    leading: Image.asset(
                      'assets/imgs/ic_about.png', width: 30.w, height: 30.w,),),

                ],
              ),
            )
          ],
        ),
    );
  }

  Widget _headerWidget(context) {
    return Container(
      margin: EdgeInsets.all(15.w),
      height: 200.h,
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
              child: notifier.mIconPath.isEmpty ? Image.asset(
                'assets/imgs/default_avatar.png',
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              ) :
              Image.file(
                File(notifier.mIconPath),
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),

            ),
            SizedBox(height: 20.h,),
            Text(
              notifier.isLogin
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
    if (notifier.isLogin) {
      Scaffold.of(context).showBottomSheet((context){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10)),
            color: Colors.grey.shade300
          ),
          height: 200.h,
          child: Column(
            children: [
              ListTile(
                title: Text("拍照", style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
                onTap: () {
                  _takePhoto(context);
                },
              ),
              Divider(),
              ListTile(
                title: Text("选择图片", style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
                onTap: () {
                  _selectPhoto(context);
                },
              ),
              Divider(),
              ListTile(
                title: Text("取消", style: Theme
                    .of(context)
                    .textTheme
                    .bodyText1,),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      });
    }
    else {
      ToastUtils.showMyToast(S
          .of(context)
          .login_first);
    }
  }

  Future _selectPhoto(ctx) async {
    final pickedFile = await picker.pickImage(
      // 拍照获取图片
      // source: ImageSource.camera,
      // 手机选择图库
        source: ImageSource.gallery,
        // 图片的最大宽度
        maxWidth: 400.w
    );
    var path = pickedFile?.path;
    if (path != null) {
      Global.saveIconPath(path);
      notifier.setIconPath(path);
    }
    Navigator.pop(ctx);
  }

  Future _takePhoto(ctx) async {
    final pickedFile = await picker.pickImage(
      // 拍照获取图片
      // source: ImageSource.camera,
      // 手机选择图库
        source: ImageSource.camera,
        // 图片的最大宽度
        maxWidth: 400.w
    );
    var path = pickedFile?.path;
    if (path != null) {
      Global.saveIconPath(path);
      notifier.setIconPath(path);
    }
    Navigator.pop(ctx);
  }
}