import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wandemo/controller/project_controller.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:wandemo/page/project_info_page.dart';

import '../../model/project_model.dart';

class ProjectPage extends GetView<ProjectController>{
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
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
    });
  }

  get _tabs {
    return TabBar(
      unselectedLabelColor: Colors.black,
      labelColor: Colors.blue,
      isScrollable: true,
      controller: controller.tabController,
      tabs: controller.categoryList.map((e) {
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
      controller: controller.tabController,
      children: controller.categoryList.map((e) {
        return ProjectInfoPage(e.id);
      }).toList(),
    );
  }
}

