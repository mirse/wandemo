import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:wandemo/model/banner_model.dart' as banner;
import 'package:wandemo/model/hotkey_model.dart' as hotkey;
import 'package:wandemo/utils/constant.dart';

import '../model/article_model.dart' as article;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  late List<banner.BannerModel> httpImg = [];
  late List<article.Datas> articleList = [];
  int _articlePage = 0;
  ScrollController _controller = ScrollController();
  var homeKeyMap = {
    '面试': 'assets/imgs/icon_iv.png',
    '大厂分享': 'assets/imgs/icon_big.png',
    '性能优化': 'assets/imgs/icon_op.png',
    '官方发布': 'assets/imgs/icon_daily.png',
    'Jetpack': 'assets/imgs/icon_jetpack.png',
    '开源库源码': 'assets/imgs/icon_open.png',
    'Framework': 'assets/imgs/icon_framework.png',
    'Kotlin': 'assets/imgs/icon_kotlin.png',
  };

  // var homeKeyList = ['面试','大厂分享','性能优化','官方发布','Jetpack','开源库源码','Framework','Kotlin'];

  @override
  void initState() {
    super.initState();
    HttpManager().getBanner<banner.BannerModel>(success:(data){
      setState(() {
        httpImg = data;
      });
    },fail: (errorCode,msg){

    });

    getHotkey().then((List<hotkey.Data> value) {
      setState(() {
        //hotkeyList = value;
      });
    });

    _getArticle(_articlePage);

    _controller.addListener(() {
      var distance = _controller.position.maxScrollExtent -
          _controller.position.pixels;
      if (distance<300 && _controller.position.maxScrollExtent != 0) {
        _articlePage++;
        _getArticle(_articlePage);
      }
    });
  }

  Future _getArticle(int page) {
    return HttpManager().getArticle(params: {
      'page':page
    },success: (data){
      setState(() {
        articleList.addAll(data);
      });
    },fail: (errorCode,msg){

    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () {
        return _getArticle(0);
        },
      child: ListView.builder(
        controller: _controller,
        itemCount: articleList.length+2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 200,
              child: Swiper(
                  key: UniqueKey(),
                  //解决 dart ScrollController not attached to any scroll views.
                  pagination: SwiperPagination(),
                  //如果不填则不显示指示点
                  itemCount: httpImg.length,
                  itemBuilder: ((context, index) {
                    return Image.network(httpImg[index].imagePath);
                  })),
            );
          } else if (index == 1) {
            return Container(
              height: 200,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(), // 禁用滑动事件,
                crossAxisCount: 4,
                children: getGridChild(),
              ),
            );
          } else {
            return getListItem(articleList[index - 2]);
          }
        }),

    );
  }

  Widget getListItem(article.Datas data) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              data.title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    //背景
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //设置四周边框
                    border: new Border.all(width: 1, color: Colors.blueAccent),
                  ),
                  child: Text(
                    data.chapterName,
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    data.collect ? Icons.favorite : Icons.favorite_border,
                    color: data.collect ? Colors.red : Colors.grey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(data.shareUser),
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Future<List<hotkey.Data>> getHotkey() async {
    Response response =
        await Dio().get('https://www.wanandroid.com//hotkey/json');
    var hotkeyModel = hotkey.HotkeyModel.fromJson(response.data);
    return hotkeyModel.data;
  }

  List<Widget> getGridChild() {
    List<Widget> widgetList = [];
    homeKeyMap.forEach((key, value) {
      widgetList.add(getGridItem(key, value));
    });
    return widgetList;
  }

  Widget getGridItem(String name, String iconPath) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Image.asset(
              iconPath,
              height: 40,
              width: 40,
            ),
            Container(
              child: Text(name),
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
