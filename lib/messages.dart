import 'package:get/get.dart';

class Messages extends Translations{
  @override

  Map<String, Map<String, String>> get keys => {
    'en_US':{
      'home':'Home',
      'project':'Home',
      'type':'Home',
      'me':'Home',
    },
    'zh_CN':{
      'home':'首页',
      'project':'项目',
      'type':'分类',
      'me':'我的',
    }


  };

}