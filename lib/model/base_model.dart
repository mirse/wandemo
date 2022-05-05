class BaseModel<T>{
  final int errorCode;
  final String errorMsg;
  final T t;
  BaseModel(this.errorCode, this.errorMsg, this.t);

}