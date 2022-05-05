typedef Success<T> = Function(T data); //typedef 给某一种特定的函数类型起了一个名字
typedef Fail = Function(int code,String msg);

//网络请求配置
const int connectTimeout = 15000;
const int receiveTimeout = 15000;
const int sendTimeout = 10000;

//网络应答码
const int success = 200;
const int success_not_content = 204;
const int unauthorized = 401;
const int forbidden = 403;
const int not_found = 404;
const int net_error = 1000;
const int parse_error = 1001;
const int socket_error = 1002;
const int http_error = 1003;
const int timeout_error = 1004;
const int cancel_error = 1005;
const int unknown_error = 9999;

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