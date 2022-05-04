import 'package:dio/dio.dart';
import 'package:wandemo/http/api.dart';
import 'package:wandemo/http/error_handle.dart';

const int _connectTimeout = 15000;//?
const int _receiveTimeout = 15000;
const int _sendTimeout = 10000;
typedef Success<T> = Function(T data);
typedef Fail<T> = Function(int code,String msg);

//https://www.cnblogs.com/zyzmlc/p/14088886.html
class DioUtils {


  static Dio _dio;
  static Dio getInstance(){
    if(_dio == null){
      var options = BaseOptions(
        //contentType:,
        responseType: ResponseType.json,
        validateStatus: (status){
          return true;
        },
        baseUrl: Apis.BASE_URL,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
      );
      _dio = new Dio(options);
    }
    return _dio;
  }

  Future request<T>(Method method,String path,dynamic params,{Success success,Fail fail}) async{
    try{
      //1、网络检查
      var _dio = getInstance();
      var response = await _dio.request(path,data: params,options: Options(method: MethodValues[method]));
      if(response != null && success != null){
        success(response.data);
      }
      else{
        _on
      }
    }
  }

  void onError(int code,String msg,Fail fail){
    if(code == null){
      code  = ExceptionHandle.unknown_error;
      msg = '未知错误';
    }
    print('接口请求错误,原因：${msg}');
    if(fail != null){
      fail(code,msg);
    }

  }



}
enum Method{
  GET,POST,DELETE,PUT,PATCH,HEAD
}
const MethodValues = {
  Method.GET:'get',
  Method.POST:'post',
  Method.DELETE:'delete',
  Method.PUT:'put',
  Method.PATCH:'patch',
  Method.HEAD:'head',

};