import 'package:wandemo/http/dio_manager.dart';

class Global{
  static Future init() async{
    await DioManager().initCookieJar();
  }
}