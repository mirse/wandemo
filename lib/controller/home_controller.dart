import 'package:get/get.dart';

import '../http/http_manager.dart';
import '../model/banner_model.dart';

class HomeController extends GetxController{

  @override
  void onInit() {

  }

  void getBanner(){
    HttpManager().getBanner<BannerModel>(success:(data){
      //httpImg = data;
    },fail: (errorCode,msg){

    });
  }


}

HomeController get homeController => Get.find<HomeController>();