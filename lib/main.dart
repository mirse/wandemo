import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      drawer: _drawer,
    );
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
        ListTitle('首页',Icons.home),
        ListTitle('项目',Icons.local_fire_department),
        ListTitle('分类',Icons.category_outlined),
        ListTitle('我的',Icons.person),
      ],
    )
  );

  get _drawerHeader => DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.blueAccent,
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
}

class ListTitle extends StatelessWidget {
  final String name;
  final IconData icon;
  ListTitle(this.name, this.icon);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            child:
            ListTile(
              leading: Icon(icon),
              title: Text(name),
            ),
          ),
          Divider(),
        ],
      ),
      onTap: ()=>print(''),
    );
  }


}

