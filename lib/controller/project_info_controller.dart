import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../http/http_manager.dart';

class ProjectInfoController extends GetxController{

  ScrollController scrollController = ScrollController();
  var projectInfoList = [].obs;
  var loading = true;
  var _page = 0;
  var _cid;

  ProjectInfoController();

  @override
  void onInit() {
    print('id:${_cid}');
    //getArticle(_cid,_page);
    scrollController.addListener(() {
      var distance = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      if (distance<300 && !loading && scrollController.position.maxScrollExtent != 0) {
        _page++;
        loading = true;
        getArticle(_cid,_page);
      }
    });
  }


  void getArticle(cid,page){
    _cid = cid;
    _page = page;
    HttpManager().getProjectInfo(params: {
      'cid':_cid,
      'page':_page,
    },success: (data){
      loading = false;
      projectInfoList.addAll(data);
    },fail: (errorCode,msg){
      loading = false;
    });
  }
}