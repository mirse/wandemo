import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ArticleInfoPage extends StatelessWidget {
  ArticleInfoPage({Key? key}) : super(key: key);
  var _url = '';
  var _title = '';

  GlobalKey webViewKey = GlobalKey();
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,//加载url拦截功能
      mediaPlaybackRequiresUserGesture: false,//多媒体控制
    ),
    /// android 支持HybridComposition
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    _url = Get.arguments['link'];
    _title = Get.arguments['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(_url)),
      ),
    );
  }
}
