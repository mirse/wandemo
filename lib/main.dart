import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wandemo/page/home_page.dart';
import 'package:wandemo/page/my_page.dart';
import 'package:wandemo/page/project/project_page.dart';
import 'package:wandemo/page/sort_page.dart';

void main() {
  runApp(const MyApp());
  if(Platform.isAndroid){
    var systemUi = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUi);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      // routes:{
      //   '/home':(BuildContext context) => HomePage(),
      //   '/project':(BuildContext context) => ProjectPage(),
      //   '/sort':(BuildContext context) => SortPage(),
      //   '/my':(BuildContext context) => MyPage(),
      // },


    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<MainPage> with TickerProviderStateMixin{
  var curIndex = 0;
  var allPages=[HomePage(),ProjectPage(),SortPage(),MyPage()];
  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      drawer: _drawer,
      bottomNavigationBar: _bottomNavigationBar,
      body: _tabBarView,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: allPages.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  get _appbar => AppBar(
    //私有方法
    title: const Text('wan android'),
  );

  get _drawer => Drawer(child:
  ListView(
    padding: EdgeInsets.zero,// 此处能解决顶部为灰色的问题
    children: [
      _drawerHeader,
      ListTile(
          textColor: curIndex==0?Colors.blueAccent:Colors.grey,
          iconColor: curIndex==0?Colors.blueAccent:Colors.grey,
          title: Text('首页'),
          leading:Icon(Icons.home),
          onTap: (){
            Navigator.of(context).pop();
            setState(() {
              curIndex = 0;
            });
          },
      ),
      Divider(),
      ListTile(
        textColor: curIndex==1?Colors.blueAccent:Colors.grey,
        iconColor: curIndex==1?Colors.blueAccent:Colors.grey,
        title: Text('项目'),
        leading:Icon(Icons.local_fire_department),
        onTap: (){
          Navigator.of(context).pop();
          setState(() {
            curIndex = 1;
          });
        },
      ),
      Divider(),
      ListTile(
        textColor: curIndex==2?Colors.blueAccent:Colors.grey,
        iconColor: curIndex==2?Colors.blueAccent:Colors.grey,
        title: Text('分类'),
        leading:Icon(Icons.category_outlined),
        onTap: (){
          Navigator.of(context).pop();
          setState(() {
            curIndex = 2;
          });
        },
      ),
      Divider(),
      ListTile(
        textColor: curIndex==3?Colors.blueAccent:Colors.grey,
        iconColor: curIndex==3?Colors.blueAccent:Colors.grey,
        title: Text('我的'),
        leading:Icon(Icons.person),
        onTap: (){
          Navigator.of(context).pop();
          setState(() {
            curIndex = 3;
          });
        },
      )
    ],
  )
  );

  get _drawerHeader => DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.blueAccent, //设置顶部背景颜色或图片
    ),
    padding: EdgeInsets.all(0),// 此处能解决DrawerHeader为灰色的问题
    child: GestureDetector(//点击事件
      child: Container(
        margin: EdgeInsets.only(left: 15),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/imgs/default_avatar.png',
                width: 70,
                height: 70,
              ),
            ),
            Container(
              color: Colors.yellow,
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'admin',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
      onTap: ()=>print('click header'),
    ),
  );

  get _bottomNavigationBar => BottomNavigationBar(
    currentIndex: curIndex,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.blue,
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: '首页'),
      BottomNavigationBarItem(icon: Icon(Icons.local_fire_department),label: '项目'),
      BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: '分类'),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: '我的'),
    ],
    onTap: (index){
      setState(() {
        print("the index is :$index");
        curIndex=index;
        _tabController?.index = index;
      });

    },
  );

  get _tabBarView{
    return TabBarView(
      controller: _tabController,
      physics: NeverScrollableScrollPhysics(),
      children: allPages,
    );
  }

}

