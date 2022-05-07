import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wandemo/main.dart';
import 'package:wandemo/page/article_info_page.dart';
import 'package:wandemo/page/login_page.dart';

final routes = {
  //"/": (context, {arguments}) => MainPage(),
  '/articleInfo': (context, {arguments}) => ArticleInfoPage(
        arguments: arguments,
      ),
  '/login': (context) => LoginPage(),
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
