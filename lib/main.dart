import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:wandemo/page/home_page.dart';
import 'package:wandemo/page/login_page.dart';
import 'package:wandemo/page/my_page.dart';
import 'package:wandemo/page/project_page.dart';
import 'package:wandemo/page/sort_page.dart';
import 'package:wandemo/route.dart';
import 'package:wandemo/utils/global.dart';
import 'package:wandemo/utils/permission_utils.dart';
import 'package:wandemo/utils/toast_utils.dart';
import 'package:wandemo/widget/dialog_widget.dart';

import 'controller/login_controller.dart';
import 'http/dio_manager.dart';

void main() async {
  runApp(const MyApp());
  PermissionUtils.requestPermission(Permission.storage, denied: () {
    print('denied');
  }, permanentlyDenied: () {
    print('permanentlyDenied');
  }, granted: () async {
    print('granted');
    await Global.init();
  });
  if (Platform.isAndroid) {
    var systemUi = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUi);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MainPage(),
          //initialRoute: '/', //与home选其一
          //routes:routes,
          onGenerateRoute: onGenerateRoute //当routes不配置走onGenerateRoute

          ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<MainPage> with TickerProviderStateMixin {
  var curIndex = 0;
  var allPages = [HomePage(), ProjectPage(), SortPage(), MyPage()];
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      drawer: _drawer,
      bottomNavigationBar: _bottomNavigationBar,
      body: _tabBarView,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: allPages.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  get _appbar => AppBar(
        //私有方法
        title: const Text('wan android'),
      );

  get _drawer => Drawer(
          child: ListView(
        padding: EdgeInsets.zero, // 此处能解决顶部为灰色的问题
        children: [
          _drawerHeader,
          ListTile(
            textColor: curIndex == 0 ? Colors.blueAccent : Colors.grey,
            iconColor: curIndex == 0 ? Colors.blueAccent : Colors.grey,
            title: Text('首页'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                curIndex = 0;
              });
            },
          ),
          Divider(),
          ListTile(
            textColor: curIndex == 1 ? Colors.blueAccent : Colors.grey,
            iconColor: curIndex == 1 ? Colors.blueAccent : Colors.grey,
            title: Text('项目'),
            leading: Icon(Icons.local_fire_department),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                curIndex = 1;
              });
            },
          ),
          Divider(),
          ListTile(
            textColor: curIndex == 2 ? Colors.blueAccent : Colors.grey,
            iconColor: curIndex == 2 ? Colors.blueAccent : Colors.grey,
            title: Text('分类'),
            leading: Icon(Icons.category_outlined),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                curIndex = 2;
              });
            },
          ),
          Divider(),
          ListTile(
            textColor: curIndex == 3 ? Colors.blueAccent : Colors.grey,
            iconColor: curIndex == 3 ? Colors.blueAccent : Colors.grey,
            title: Text('我的'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).pop();
              setState(() {
                curIndex = 3;
              });
            },
          )
        ],
      ));

  get _drawerHeader => Obx(() {
        return DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blueAccent, //设置顶部背景颜色或图片
          ),
          padding: EdgeInsets.all(0), // 此处能解决DrawerHeader为灰色的问题
          child: GestureDetector(
            //点击事件
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/imgs/default_avatar.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      appState.isLogin
                          ? (Global.loginInfoModel == null
                              ? 'admin'
                              : Global.loginInfoModel!.nickname)
                          : 'admin',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              //点击drawer首栏
              if (!Global.getLoginState()) {
                LoadingDialog.show();
                // Navigator.of(context).pushNamed(
                //   '/login',
                // );
              } else {
                Get.dialog(MyDialog(
                  '退出登录',
                  '确定',
                  () {
                    HttpManager().loginOut(success: (data){
                      ToastUtils.showToast('退出登录成功');
                      Global.clearUserInfo();
                      DioManager().clearCookieJar();
                      appState.setLoginState(LoginState.LOGIN_OUT);
                      Get.back();
                    },fail:(errorCode,msg){
                      ToastUtils.showToast('退出登录失败：${msg}');
                      Get.back();
                    });
                  },
                  cancelText: '取消',
                  onCancel: (){

                  },
                ));
              }
            },
          ),
        );
      });

  get _bottomNavigationBar => BottomNavigationBar(
        currentIndex: curIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department), label: '项目'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: '分类'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
        onTap: (index) {
          setState(() {
            print("the index is :$index");
            curIndex = index;
            _tabController?.index = index;
          });
        },
      );

  get _tabBarView {
    // return TabBarView(
    //   controller: _tabController,
    //   physics: NeverScrollableScrollPhysics(),
    //   children: allPages,
    // );
    return IndexedStack(
      //切换无动画
      // controller: _tabController,
      // physics: NeverScrollableScrollPhysics(),
      index: curIndex, //The index of the child to show.
      children: allPages,
    );
  }
}
