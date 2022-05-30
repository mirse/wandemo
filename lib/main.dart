import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:wandemo/messages.dart';
import 'package:wandemo/notifier/app_notifier.dart';
import 'package:wandemo/notifier/home_notifier.dart';
import 'package:wandemo/notifier/login_notifier.dart';
import 'package:wandemo/notifier/setting_notifier.dart';
import 'package:wandemo/page/home_page.dart';
import 'package:wandemo/page/login_page.dart';
import 'package:wandemo/page/my_page.dart';
import 'package:wandemo/page/project_page.dart';
import 'package:wandemo/page/setting_page.dart';
import 'package:wandemo/page/sort_page.dart';
import 'package:wandemo/page/splash_page.dart';
import 'package:wandemo/route.dart';
import 'package:wandemo/utils/app_theme.dart';
import 'package:wandemo/utils/global.dart';
import 'package:wandemo/utils/permission_utils.dart';
import 'package:wandemo/utils/toast_utils.dart';
import 'package:wandemo/widget/dialog_widget.dart';

import 'generated/l10n.dart';
import 'http/dio_manager.dart';

/**
 *  GetBuilder是手动状态管理器，需要更改时需要主动调用update(),内存消耗比较少
 *  getX可以实现自动响应数据变化，相比Obx可以实现初始化controller.生命周期回收等，效率比GetBuilder、Obx低
 *
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SettingNotifier>(create: (ctx) => SettingNotifier()),
      ChangeNotifierProvider<AppNotifier>(create: (ctx) => AppNotifier()),
      ChangeNotifierProvider<HomeNotifier>(create: (ctx) => HomeNotifier(ctx)),
    ],
    child: MyApp(),
  ));
  _requestPermission();
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

void _requestPermission(){
  PermissionUtils.requestPermission(Permission.storage, denied: () {
    print('denied');
  }, permanentlyDenied: () {
    print('permanentlyDenied');
  }, granted: () async {
    print('granted');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360,640),
        builder: (ctx,widget) => OKToast(
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Consumer<SettingNotifier>(
                  builder: (ctx,local,child){
                    return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Flutter Demo',
                        //routes: routes,
                        //initialRoute: '/',
                        home: SplashPage(),
                        locale:
                        local.local,
                        // Global.getLanguage() == 0 ? Locale("zh", "CN") : Locale("en", "US"),
                        localizationsDelegates: [
                          GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
                          GlobalWidgetsLocalizations.delegate, // 对应的Cupertino风格
                          GlobalCupertinoLocalizations.delegate, // 指定默认的文本排列方向, 由左到右或由右到左
                          S.delegate
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        onGenerateRoute: onGenerateRoute,
                        //当routes不配置走onGenerateRoute

                        darkTheme: darkTheme,
                        themeMode: ThemeMode.light,
                        theme:
                        local.theme
                      // Global.getIfLightTheme() == true ? lightTheme : darkTheme,
                    );
                  }),
            )
        ));
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
          drawerHeader(),
          ListTile(
            textColor: curIndex == 0 ? Colors.blueAccent : Colors.grey,
            iconColor: curIndex == 0 ? Colors.blueAccent : Colors.grey,
            title: Text(S.of(context).home),
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
            title: Text(S.of(context).project),
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
            title: Text(S.of(context).type),
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
            title: Text(S.of(context).me),
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

  Widget drawerHeader(){
    return Consumer<AppNotifier>(
      builder: (BuildContext context, appNotifier, Widget? child) {
        return DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, //设置顶部背景颜色或图片
          ),
          padding: EdgeInsets.all(0), // 此处能解决DrawerHeader为灰色的问题
          child: GestureDetector(
            //点击事件
            child: Container(
              margin: EdgeInsets.only(left: 15.w),
              child: Row(
                children: [
                  ClipOval(
                    child: appNotifier.mIconPath.isEmpty
                        ? Image.asset(
                      'assets/imgs/default_avatar.png',
                      width: 70.w,
                      height: 70.w,
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      File(appNotifier.mIconPath),
                      width: 70.w,
                      height: 70.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    child: Text(
                      appNotifier.isLogin
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
              if (!appNotifier.isLogin) {
                Navigator.pushNamed(context, '/login');
              } else {
                showDialog(context: context, builder: (_){
                  return MyDialog(
                    context,
                    S.of(context).logout,
                    S.of(context).ok,
                        () {
                      Navigator.pop(context);
                      LoadingDialog.show(context);
                      HttpManager().loginOut(success: (data) {
                        ToastUtils.showMyToast(S.of(context).logout_success);
                        Global.clearUserInfo();
                        Global.clearIconPath();
                        DioManager().clearCookieJar();
                        appNotifier.setLoginState(LoginState.LOGIN_OUT);
                        appNotifier.setIconPath(Global.iconPath);
                        LoadingDialog.dismissDialog(context);
                      }, fail: (errorCode, msg) {
                        ToastUtils.showMyToast(S.of(context).logout_fail);
                        LoadingDialog.dismissDialog(context);
                      });
                    },
                    cancelText: S.of(context).cancel,
                    onCancel: () {},
                  );
                });
              }
            },
          ),
        );
      },

    );
  }

  get _bottomNavigationBar => BottomNavigationBar(
        currentIndex: curIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: S.of(context).home),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department), label: S.of(context).project),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: S.of(context).type),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: S.of(context).me),
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
