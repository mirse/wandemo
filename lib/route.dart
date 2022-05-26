import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:wandemo/bindings/home_bindings.dart';
import 'package:wandemo/bindings/login_bindings.dart';
import 'package:wandemo/bindings/project_bindings.dart';
import 'package:wandemo/bindings/project_info_bindings.dart';
import 'package:wandemo/controller/project_controller.dart';
import 'package:wandemo/main.dart';
import 'package:wandemo/page/article_info_page.dart';
import 'package:wandemo/page/login_page.dart';
import 'package:wandemo/page/my_page.dart';
import 'package:wandemo/page/setting_page.dart';
import 'package:wandemo/page/splash_page.dart';

List<GetPage> pages = [
  GetPage(name: '/splash', page: () => SplashPage()),
  GetPage(name: '/home', page: () => MainPage(),bindings: [ProjectBindings(),HomeBindings()]),
  GetPage(name: '/articleInfo', page: () => ArticleInfoPage()),
  GetPage(name: '/login', page: () => LoginPage(),binding: LoginBindings()),
  GetPage(name: '/setting', page: () => SettingPage()),
];


final routes = {
  //"/": (context, {arguments}) => MainPage(),
  '/articleInfo': (context, {arguments}) => ArticleInfoPage(
        //arguments: arguments,
      ),
  '/login': (context) => LoginPage(),
  '/splash': (context) => SplashPage(),
  '/home': (context) => MainPage(),
  '/setting': (context) => SettingPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  //String? 表示name为可空类型
  final String? name = settings.name;
  //Function? 表示pageContentBuilder为可空类型
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
      MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return MaterialPageRoute(builder: (context) => MyApp());;
};
