import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../http/http_manager.dart';


class ProjectController extends GetxController with GetTickerProviderStateMixin {
  var _categoryList = [].obs;
  var tabController;

  ProjectController();

  RxList get categoryList => _categoryList;


  @override
  void onClose() {

  }

  @override
  void onReady() {

  }

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: _categoryList.length);
    HttpManager().getProject(
        success: (data) {
          _categoryList.value = data;
          tabController = TabController(vsync: this, length: _categoryList.length);
        },
        fail: (errorCode, msg) {});
  }

}