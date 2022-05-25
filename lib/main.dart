import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wandemo/controller/app_controller.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:wandemo/messages.dart';
import 'package:wandemo/page/home_page.dart';
import 'package:wandemo/page/login_page.dart';
import 'package:wandemo/page/my_page.dart';
import 'package:wandemo/page/project_page.dart';
import 'package:wandemo/page/sort_page.dart';
import 'package:wandemo/route.dart';
import 'package:wandemo/utils/app_theme.dart';
import 'package:wandemo/utils/global.dart';
import 'package:wandemo/utils/permission_utils.dart';
import 'package:wandemo/utils/toast_utils.dart';
import 'package:wandemo/widget/dialog_widget.dart';

import 'controller/login_controller.dart';
import 'http/dio_manager.dart';

/**
 *  GetBuilder是手动状态管理器，需要更改时需要主动调用update(),内存消耗比较少
 *  getX可以实现自动响应数据变化，相比Obx可以实现初始化controller.生命周期回收等，效率比GetBuilder、Obx低
 *
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(const MyApp());
  PermissionUtils.requestPermission(Permission.storage, denied: () {
    print('denied');
  }, permanentlyDenied: () {
    print('permanentlyDenied');
  }, granted: () async {
    print('granted');
  });
  if (Platform.isAndroid) {
    var systemUi = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUi);

    //todo flutter 使用setEnabledSystemUIMode在某些机型上状态栏出现黑条，https://github.com/flutter/flutter/issues/64274，
    //todo 修改MainActivity代码如何生效
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
    //     overlays: [
    //       SystemUiOverlay.bottom, SystemUiOverlay.top
    //     ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 640),
        builder: (ctx, widget) => OKToast(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  //home: MainPage(),
                  initialRoute: '/splash',
                  //与home选其一
                  //routes:routes,
                  getPages: pages,
                  locale: Global.getLanguage() == 0
                      ? Locale("zh", "CN")
                      : Locale("en", "US"),
                  translations: Messages(),
                  fallbackLocale: Locale("zh", "CN"),
                  //默认语言
                  //onGenerateRoute: onGenerateRoute //当routes不配置走onGenerateRoute
                  darkTheme: darkTheme,
                  themeMode: ThemeMode.light,
                  theme:
                      Global.getIfLightTheme() == true ? lightTheme : darkTheme,
                ))));
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
            title: Text('home'.tr),
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
            title: Text('project'.tr),
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
            title: Text('type'.tr),
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
            title: Text('me'.tr),
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
            color: Theme.of(context).primaryColor, //设置顶部背景颜色或图片
          ),
          padding: EdgeInsets.all(0), // 此处能解决DrawerHeader为灰色的问题
          child: GestureDetector(
            //点击事件
            child: Container(
              margin: EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  ClipOval(
                    child: appController.mIconPath.isEmpty
                        ? Image.asset(
                            'assets/imgs/default_avatar.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(appController.mIconPath),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      appController.isLogin
                          ? (Global.loginInfoModel == null
                              ? 'admin'
                              : Global.loginInfoModel!.nickname)
                          : 'admin',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              //点击drawer首栏
              if (!appController.isLogin) {
                Get.toNamed('/login');
              } else {
                Get.dialog(MyDialog(
                  'logout'.tr,
                  'ok'.tr,
                  () {
                    Get.back();
                    LoadingDialog.show();
                    HttpManager().loginOut(success: (data) {
                      ToastUtils.showMyToast('logout_success'.tr);
                      Global.clearUserInfo();
                      DioManager().clearCookieJar();
                      appController.setLoginState(LoginState.LOGIN_OUT);
                      LoadingDialog.dismiss();
                    }, fail: (errorCode, msg) {
                      ToastUtils.showMyToast('logout_fail'.tr + ':$msg');
                      LoadingDialog.dismiss();
                    });
                  },
                  cancelText: 'cancel'.tr,
                  onCancel: () {},
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department), label: 'project'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'type'.tr),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'me'.tr),
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
