
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sp_util/sp_util.dart';

import '../generated/l10n.dart';
import '../http/http_manager.dart';
import '../model/banner_model.dart';
import '../utils/app_theme.dart';
import '../utils/global.dart';
import '../utils/toast_utils.dart';
import '../widget/dialog_widget.dart';


class HomeNotifier extends ChangeNotifier{

  ScrollController scrollController = ScrollController();
  List articleList = [];
  List httpImg = [];
  int _articlePage = 0;
  var ctx;

  set articlePage(articlePage){
    _articlePage = articlePage;
  }


  HomeNotifier(this.ctx){
    print('HomeNotifier build');
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
    // ever(appController.loginState, (callBack) {
    //   //每次登录状态发生变化，都要重新请求广场数据
    //   _articlePage = 0;
    //   getArticle();
    // });
  }

  void getBanner(){
    HttpManager().getBanner<BannerModel>(success:(data){
      httpImg = data;
    },fail: (errorCode,msg){

    });
    notifyListeners();
  }

  Future getArticle() {
    return HttpManager().getArticle(params: {
      'page':_articlePage
    },success: (data){
      if(_articlePage == 0){
        articleList.clear();
      }
      articleList.addAll(data);
      notifyListeners();
    },fail: (errorCode,msg){

    });

  }

  void collectArticle(int index) {
    LoadingDialog.show(ctx);
    HttpManager().collectArticleIn(params: {
      'id':articleList[index].id
    },success: (data){
      articleList[index].collect = true;
      //todo obx List刷新方法
      // articleList.refresh();
      ToastUtils.showMyToast(S.of(ctx).collect_success);
      LoadingDialog.dismissDialog(ctx);
      notifyListeners();
    },fail: (errorCode,msg){
      articleList[index].collect = false;
      // articleList.refresh();
      ToastUtils.showMyToast(S.of(ctx).collect_fail+':$msg');
      notifyListeners();
      LoadingDialog.dismissDialog(ctx);
    });

  }

  void unCollectArticle(int index) {
    LoadingDialog.show(ctx);
    HttpManager().unCollectArticleIn(params: {
      'id':articleList[index].id
    },success: (data){
      articleList[index].collect = false;
      // articleList.refresh();
      ToastUtils.showMyToast(S.of(ctx).uncollect_success);
      LoadingDialog.dismissDialog(ctx);
      notifyListeners();
    },fail: (errorCode,msg){
      articleList[index].collect = true;
      // articleList.refresh();
      ToastUtils.showMyToast(S.of(ctx).uncollect_fail+':$msg');
      LoadingDialog.dismissDialog(ctx);
      notifyListeners();
    });

  }

  bool getIsCollect(index){
    return articleList[index].collect;
  }


}