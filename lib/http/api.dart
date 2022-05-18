import 'package:cookie_jar/cookie_jar.dart';

class Apis{

  static const String URL_BASE = 'https://www.wanandroid.com/';
  static const String URL_BANNER = 'banner/json';
  static const String URL_ARTICLE = 'article/list/:page/json';

  static const String URL_PROJECT = 'project/tree/json';

  static const String URL_PROJECT_INFO = 'project/list/:page/json?cid=:cid';

  static const String URL_LOGIN = 'user/login';
  static const String URL_LOGIN_OUT = 'user/logout/json';
}