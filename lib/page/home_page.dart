import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wandemo/model/banner_model.dart' as banner;
import 'package:wandemo/model/hotkey_model.dart' as hotkey;

import '../model/article_model.dart' as article;



class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}

class HomeState extends State{
  late List<banner.Data> httpImg = [];
  late List<article.Datas> articleList = [];

  var homeKeyMap = {
    '面试':'assets/imgs/icon_iv.png',
    '大厂分享':'assets/imgs/icon_big.png',
    '性能优化':'assets/imgs/icon_op.png',
    '官方发布':'assets/imgs/icon_daily.png',
    'Jetpack':'assets/imgs/icon_jetpack.png',
    '开源库源码':'assets/imgs/icon_open.png',
    'Framework':'assets/imgs/icon_framework.png',
    'Kotlin':'assets/imgs/icon_kotlin.png',
  };
  // var homeKeyList = ['面试','大厂分享','性能优化','官方发布','Jetpack','开源库源码','Framework','Kotlin'];

  @override
  void initState() {
    super.initState();
    getBanner().then((List<banner.Data> value) {
      setState(() {
        httpImg = value;
      });
    });

    getHotkey().then((List<hotkey.Data> value) {
      setState(() {
        //hotkeyList = value;
      });
    });

    getArticle().then((List<article.Datas> value) {
      setState(() {
        articleList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      if(index == 0){
        return Container(
          height: 200,
          child: Swiper(
              key: UniqueKey(), //dart ScrollController not attached to any scroll views.
              pagination: SwiperPagination(),//如果不填则不显示指示点
              itemCount: httpImg.length,
              itemBuilder:((context,index){
                return Image.network(httpImg[index].imagePath);
              })
          ),
        );
      }
      else if(index == 1){
        return Container(
          height: 200,
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),// 禁用滑动事件,
            crossAxisCount: 4,
            children: getGridChild(),
          ),
        );
      }
      else{
        return getListItem(articleList[index-2]);
      }
    });
  }

  Widget getListItem(article.Datas data){
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(data.title,style: TextStyle(fontWeight: FontWeight.w500 ),),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height:25,
                  width: 40,
                  decoration: BoxDecoration(
                    //背景
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //设置四周边框
                    border: new Border.all(width: 1, color: Colors.blueAccent),
                  ),
                  child: Text(data.chapterName,style: TextStyle(color: Colors.blueAccent,),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    data.collect?Icons.favorite:Icons.favorite_border,
                    color: data.collect?Colors.red:Colors.grey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child:Text(data.shareUser),
                )

              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Future<List<banner.Data>> getBanner() async{
    Response response = await Dio().get('https://www.wanandroid.com/banner/json');
    var bannerModel = banner.BannerModel.fromJson(response.data);
    return bannerModel.datas;
  }

  Future<List<hotkey.Data>> getHotkey() async{
    Response response = await Dio().get('https://www.wanandroid.com//hotkey/json');
    var hotkeyModel = hotkey.HotkeyModel.fromJson(response.data);
    return hotkeyModel.data;
  }

  Future<List<article.Datas>> getArticle() async{
    Response response = await Dio().get('https://www.wanandroid.com/article/list/0/json');
    var articleModel = article.ArticleModel.fromJson(response.data);
    return articleModel.data.datas;
  }

  List<Widget> getGridChild(){
    List<Widget> widgetList = [];
    homeKeyMap.forEach((key, value) {
      widgetList.add(getGridItem(key, value));
    });
    return widgetList;
  }

  Widget getGridItem(String name,String iconPath) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Image.asset(iconPath,height: 40,width: 40,),
          Container(
            child:Text(name) ,
          )
        ],
      )
    );
  }

}