import 'package:wandemo/http/api.dart';
import 'package:wandemo/http/dio_manager.dart';
import '../utils/constant.dart';

class HttpManager {
  HttpManager._init();

  static final HttpManager _instance = HttpManager._init();

  factory HttpManager() {
    return _instance;
  }

  void getBanner<T>({Map<String, dynamic>? params,data, Success? success, Fail? fail}) {
    get<T>(Apis.URL_BANNER, params:params, data: data, success: success, fail: fail);
  }

  void get<T>(String url, {Map<String, dynamic>? params,data, Success? success, Fail? fail}) {
    //required 表示必须传入,使得它们不为空
    _request(Method.GET, url, params:params, data: data, success: success, fail: fail);
  }

  //post 请求
  void post<T>(String url, {Map<String, dynamic>? params,data,Success? success, Fail? fail,}) {
    _request(Method.POST, url, params:params, data: data, success: success, fail: fail);
  }

  void _request<T>(Method method, String url, {Map<String, dynamic>? params,data, Success? success, Fail? fail}) {
    params?.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url.replaceAll(':$key', value.toString());
      }
    });
    DioManager().request(method, url ,data: data, success: (data) {
      if (data['errorCode'] == 0) {
        if (success != null) {
          // var bannerModel = banner.BannerModel.fromJson(data);
          // return bannerModel.datas;
          success(data);
        } else {

        }
      }
    }, fail: (code, msg) {
      if (fail != null) {
        fail(code, msg);
      }
    });
  }
}
