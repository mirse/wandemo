import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ArticleInfoPage extends StatelessWidget {
  final arguments;
  ArticleInfoPage({Key? key, this.arguments}) : super(key: key);
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
    _url = arguments['link'];
    _title = arguments['title'];
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
