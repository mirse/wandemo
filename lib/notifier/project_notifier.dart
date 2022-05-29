
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../http/http_manager.dart';

class ProjectNotifier extends ChangeNotifier{
  var _categoryList = [];
  var tabController;

  ProjectNotifier(tickerProvider){
    tabController = TabController(vsync: tickerProvider, length: _categoryList.length);
    HttpManager().getProject(
        success: (data) {
          _categoryList = data;
           tabController = TabController(vsync: tickerProvider, length: _categoryList.length);
          notifyListeners();
        },
        fail: (errorCode, msg) {});

  }

  get categoryList => _categoryList;


}