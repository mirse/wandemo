import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wandemo/http/api.dart';
import '../utils/constant.dart';

//https://www.cnblogs.com/zyzmlc/p/14088886.html
class DioManager {
  //const int _receiveTimeout = 15000; //声明类成员变量时，const变量必须同时被声明为static的
  late Dio _dio;
  DioManager._init(){//私有构造函数 ,命名构造函数
    if(_dio == null){
      var options = BaseOptions(
        //contentType:,
        responseType: ResponseType.json,
        validateStatus: (status) {
          return true;
        },
        baseUrl: Apis.URL_BASE,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      );
      _dio = Dio(options);
    }
  }
  static final DioManager _instance = DioManager._init();//保存单例

  factory DioManager(){//执行构造函数并不总是创建这个类的一个新实例时，则使用 factory 关键字
    return _instance;
  }

  Future request<T>(Method method, String path, {data,
      Success? success, Fail? fail}) async {
    try {
      //TODO 网络检查
      var response = await _dio.request(path, data: data, options: Options(method: MethodValues[method]));
      if (response != null && success != null) {
        success(response.data);
      } else {
        _onError(unknown_error, '未知错误', fail);
      }
    } on DioError catch (e) {
      NetError netError = handleException(e);
      _onError(netError.code, netError.msg, fail);
    }
  }

  void _onError(int code, String msg, Fail? fail) {
    if (code == null) {
      code = unknown_error;
      msg = '未知错误';
    }
    print('接口请求错误,原因：${msg}');
    if (fail != null) {
      fail(code, msg);
    }
  }

  NetError handleException(DioError error) {
    if (error is DioError) {
      if (error.type == DioErrorType.other ||
          error.type == DioErrorType.response) {
        dynamic e = error.error;
        if (e is SocketException) {
          return NetError(socket_error, '网络异常，请检查你的网络！');
        }
        if (e is HttpException) {
          return NetError(http_error, '服务器异常！');
        }
        if (e is FormatException) {
          return NetError(parse_error, '数据解析错误！');
        }
        return NetError(net_error, '网络异常，请检查你的网络！');
      } else if (error.type == DioErrorType.connectTimeout ||
          error.type == DioErrorType.sendTimeout ||
          error.type == DioErrorType.receiveTimeout) {
        //  连接超时 || 请求超时 || 响应超时
        return NetError(timeout_error, '连接超时！');
      } else if (error.type == DioErrorType.cancel) {
        return NetError(cancel_error, '取消请求');
      } else {
        return NetError(unknown_error, '未知异常');
      }
    } else {
      return NetError(unknown_error, '未知异常');
    }
  }
}

class NetError {
  int code;
  String msg;
  NetError(this.code, this.msg);
}
