import 'package:wandemo/http/api.dart';
import 'package:wandemo/http/dio_manager.dart';
import 'package:wandemo/model/article_model.dart';
import 'package:wandemo/model/project_info_model.dart';
import 'package:wandemo/model/project_model.dart';
import '../model/banner_model.dart';
import '../utils/constant.dart';

class HttpManager {
  HttpManager._init();

  static final HttpManager _instance = HttpManager._init();

  factory HttpManager() {
    return _instance;
  }

  /**
   * 获取Banner
   */
  void getBanner<T>({Map<String, dynamic>? params,data, Success? success, Fail? fail}) {
    _get<T>(Apis.URL_BANNER, params: params, data: data, success: (data) {
      List list = data['data'];
      List<BannerModel> bannerList = list.map((e){
        return BannerModel.fromJson(e);
      }).toList();
      if (success != null) {
        success(bannerList);
      }
    }, fail: fail);
  }

  void getArticle<T>({Map<String, dynamic>? params,data, Success? success, Fail? fail}) {
    _get<T>(Apis.URL_ARTICLE, params: params, data: data, success: (data) {
      var articleModel = data['data'];
      if (success != null) {
        List list = articleModel['datas'];
        List<Datas> datas =list.map((e){
          return Datas.fromJson(e);
        }).toList();
        success(datas);
      }
    }, fail: fail);
  }

  void getProject({Map<String, dynamic>? params,data, Success? success, Fail? fail}){
    _get(Apis.URL_PROJECT,params: params,data: data,success: (data){
      List list = data['data'];
      List<ProjectModel> categoryList = list.map((e){
        return ProjectModel.fromJson(e);
      }).toList();
      if (success != null) {
        success(categoryList);
      }
    },fail: fail);
  }

  void getProjectInfo({Map<String, dynamic>? params,data, Success? success, Fail? fail}){
    _get(Apis.URL_PROJECT_INFO,params: params,data: data,success: (data){
      var projectModel = data['data'];
      if (success != null) {
        List list = projectModel['datas'];
        List<ProjectInfoModel> datas =list.map((e){
          return ProjectInfoModel.fromJson(e);
        }).toList();
        success(datas);
      }
    },fail: fail);
  }


  void _get<T>(String url, {Map<String, dynamic>? params,data, Success? success, Fail? fail}) {
    //required 表示必须传入,使得它们不为空
    _request(Method.GET, url, params:params, data: data, success: success, fail: fail);
  }

  //post 请求
  void _post<T>(String url, {Map<String, dynamic>? params,data,Success? success, Fail? fail,}) {
    _request(Method.POST, url, params:params, data: data, success: success, fail: fail);
  }

  void _request<T>(Method method, String url, {Map<String, dynamic>? params,data, Success? success, Fail? fail}) {
    params?.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    print('_request url:${url}');
    DioManager().request(method, url ,data: data, success: (data) {
      if (data['errorCode'] == 0) {
        if (success != null) {
          // var bannerModel = banner.BannerModel.fromJson(data);
          // return bannerModel.datas;
          success(data);
        } else {
          print('success is null!!');
        }
      }
    }, fail: (code, msg) {
      if (fail != null) {
        fail(code, msg);
      }
    });
  }
}
