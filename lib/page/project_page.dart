import 'package:flutter/material.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:wandemo/page/project_info_page.dart';

import '../../model/project_model.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{ //TickerProviderStateMixin:TabController(vsync: this)
  List<ProjectModel> categoryList = [];
  TabController? _controller;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: [
          Container(
            child: _tabs,
            // color: Theme.of(context).cardColor,
          )
          ,Expanded(
            child: _tabBarView
          )
        ],
      ),
    );
  }

  get _tabs {
    return TabBar(
      unselectedLabelColor: Colors.black,
      labelColor: Colors.blue,
      isScrollable: true,
      controller: _controller,
      tabs: categoryList.map((e) {
        return Tab(
          child: Text(e.name),
        );
      }).toList(),
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.blue, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15)),
    );
  }

  get _tabBarView {
    return TabBarView(
      controller: _controller,
      children: categoryList.map((e) {
         return ProjectInfoPage(e.id);
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    HttpManager().getProject(
        success: (data) {
          setState(() {
            categoryList = data;
            _controller = TabController(length: categoryList.length, vsync: this);
          });
        },
        fail: (errorCode, msg) {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

