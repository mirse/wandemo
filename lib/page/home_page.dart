import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:wandemo/controller/home_controller.dart';
import 'package:wandemo/notifier/home_notifier.dart';

class HomePage extends StatelessWidget {

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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HomeNotifier(context),
      child: Consumer<HomeNotifier>(
        builder: (ctx,notifier,child){
          return RefreshIndicator(
            onRefresh: () {
              notifier.articlePage = 0;
              return notifier.getArticle();
            },
            child: ListView.builder(
                controller: notifier.scrollController,
                itemCount: notifier.articleList.length+2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: 200,
                      child: Swiper(
                          key: UniqueKey(),
                          //解决 dart ScrollController not attached to any scroll views.
                          pagination: SwiperPagination(),
                          //如果不填则不显示指示点
                          itemCount: notifier.httpImg.length,
                          itemBuilder: ((context, index) {
                            return Image.network(notifier.httpImg[index].imagePath);
                          })),
                    );
                  } else if (index == 1) {
                    return Container(
                      height: 200,
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(), // 禁用滑动事件,
                        crossAxisCount: 4,
                        children: getGridChild(context),
                      ),
                    );
                  } else {
                    return getListItem(notifier,context,(index - 2));
                  }
                }),
          );
        },
      ),
    );
  }

  List<Widget> getGridChild(context) {
    List<Widget> widgetList = [];
    homeKeyMap.forEach((key, value) {
      widgetList.add(getGridItem(context,key, value));
    });
    return widgetList;
  }

  Widget getGridItem(context,String name, String iconPath) {
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
              child: Text(name,style: Theme.of(context).textTheme.bodyText2,),
            )
          ],
        ));
  }

  Widget getListItem(notifier,context,index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                notifier.articleList[index].title,
                style: Theme.of(context).textTheme.bodyText1,
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
                      notifier.articleList[index].chapterName,
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      child: Icon(
                        notifier.getIsCollect(index) ? Icons.favorite : Icons.favorite_border,
                        color: notifier.getIsCollect(index) ? Colors.red : Colors.grey,
                      ),
                      onTap: (){
                        notifier.getIsCollect(index)?notifier.unCollectArticle(index):notifier.collectArticle(index);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(notifier.articleList[index].shareUser,style: Theme.of(context).textTheme.bodyText2,),
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
      onTap:(){
        Navigator.pushNamed(context, '/articleInfo',arguments: {'link':notifier.articleList[index].link,'title':notifier.articleList[index].title});
      },
    );
  }
}