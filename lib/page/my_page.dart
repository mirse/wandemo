import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import '../utils/global.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          _header,

        ],
      ),
    );
  }

  get _header{
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/imgs/default_avatar.png',
              width: 70,
              height: 70,
            ),
          ),
          Container(
            child: Text(
              appController.isLogin
                  ? (Global.loginInfoModel == null
                  ? 'admin'
                  : Global.loginInfoModel!.nickname)
                  : 'admin',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}