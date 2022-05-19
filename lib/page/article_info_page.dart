import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class ArticleInfoPage extends StatefulWidget {
  // const ArticleInfoPage({Key? key, this.arguments}) : super(key: key);
  // final Map? arguments;
  @override
  _ArticleInfoPageState createState() => _ArticleInfoPageState();
}

class _ArticleInfoPageState extends State<ArticleInfoPage> {
  var _url = '';
  var _title = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = Get.arguments['link'];
    _title = Get.arguments['title'];
    // _url = widget.arguments?['link'];
    // _title = widget.arguments?['title'];
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(_url)),
      ),
    );
  }

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
}
