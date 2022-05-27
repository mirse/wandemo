import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wandemo/notifier/project_notifier.dart';
import 'package:wandemo/page/project_info_page.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with TickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //tabController = TabController(vsync: this, length: _categoryList.length);

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProjectNotifier(ctx),
      child: Consumer(
        builder: (BuildContext context, value, Widget? child) {
          return Container(
            child: Column(
              children: [
                Container(
                  child: tabs(context),
                  // color: Theme.of(context).cardColor,
                )
                ,Expanded(
                    child: tabBarView(context)
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget tabs(notifier){
    return TabBar(
      unselectedLabelColor: Colors.black,
      labelColor: Colors.blue,
      isScrollable: true,
      controller: notifier.tabController,
      tabs: notifier.categoryList.map((e) {
        return Tab(
          child: Text(e.name),
        );
      }).toList(),
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.blue, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15)),
    );
  }

  Widget tabBarView(notifier) {
    return TabBarView(
      controller: notifier.tabController,
      children: notifier.categoryList.map((e) {
        return ProjectInfoPage(e.id);
      }).toList(),
    );
  }
}



