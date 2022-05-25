import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../http/http_manager.dart';
import '../model/article_model.dart';
import '../model/banner_model.dart';
import '../utils/toast_utils.dart';
import '../widget/dialog_widget.dart';
import 'app_controller.dart';

class HomeController extends GetxController{
  ScrollController scrollController = ScrollController();
  RxList articleList = [].obs;
  RxList httpImg = [].obs;
  int _articlePage = 0;

  set articlePage(articlePage){
    _articlePage = articlePage;
  }

  @override
  void onInit() {
    _articlePage = 0;
    getArticle();
    getBanner();
    scrollController.addListener(() {
      var distance = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      if (distance<300 && scrollController.position.maxScrollExtent != 0) {
        _articlePage++;
        getArticle();
      }
    });

    ever(appController.loginState, (callBack) {
      //每次登录状态发生变化，都要重新请求广场数据
      _articlePage = 0;
      getArticle();
    });
  }

  void getBanner(){
    HttpManager().getBanner<BannerModel>(success:(data){
      httpImg.value = data;
    },fail: (errorCode,msg){

    });
  }

  Future getArticle() {
    return HttpManager().getArticle(params: {
      'page':_articlePage
    },success: (data){
      if(_articlePage == 0){
        articleList.clear();
      }
      articleList.addAll(data);
    },fail: (errorCode,msg){

    });
  }

  void collectArticle(int index) {
    LoadingDialog.show();
    HttpManager().collectArticleIn(params: {
      'id':articleList[index].id
    },success: (data){
      articleList[index].collect = true;
      //todo obx List刷新方法
      articleList.refresh();
      ToastUtils.showMyToast('collect_success'.tr);
      LoadingDialog.dismiss();
    },fail: (errorCode,msg){
      articleList[index].collect = false;
      articleList.refresh();
      ToastUtils.showMyToast('collect_fail'.tr+':$msg');
      LoadingDialog.dismiss();
    });
  }

  void unCollectArticle(int index) {
    LoadingDialog.show();
    HttpManager().unCollectArticleIn(params: {
      'id':articleList[index].id
    },success: (data){
      articleList[index].collect = false;
      articleList.refresh();
      ToastUtils.showMyToast('uncollect_success'.tr);
      LoadingDialog.dismiss();
    },fail: (errorCode,msg){
      articleList[index].collect = true;
      articleList.refresh();
      ToastUtils.showMyToast('uncollect_fail'.tr+':$msg');
      LoadingDialog.dismiss();
    });
  }

  bool getIsCollect(index){
    return articleList[index].collect;
  }
}
