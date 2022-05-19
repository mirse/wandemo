import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import '../utils/global.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade300,
      child: Column(
        children: [
          _header,
          Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              children: [
                ListTile(title: Text('收藏'),leading: Image.asset('assets/imgs/ic_zan.png',width: 30,height: 30,),),
                Divider(),
                ListTile(title: Text('排名'),leading: Image.asset('assets/imgs/ic_rank.png',width: 30,height: 30,),),
                Divider(),
                ListTile(title: Text('设置'),leading: Image.asset('assets/imgs/ic_setting.png',width: 30,height: 30,),),
                Divider(),
                ListTile(title: Text('关于'),leading: Image.asset('assets/imgs/ic_about.png',width: 30,height: 30,),),
              ],
            ),
          )
        ],
      ),
    );
  }

  get _header{
    return Container(
      margin: EdgeInsets.all(15),
      height: 200,
      width: double.infinity,
      //color: Colors.blueAccent,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/imgs/default_avatar.png',
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            appController.isLogin
                ? (Global.loginInfoModel == null
                ? 'admin'
                : Global.loginInfoModel!.nickname)
                : 'admin',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}