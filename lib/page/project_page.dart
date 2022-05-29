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
  var tabController;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (ctx){
        print('ProjectNotifier build');
        return ProjectNotifier(this);
      },
      child: Consumer<ProjectNotifier>(
        builder: (BuildContext context, value, Widget? child) {
          return Container(
            child: Column(
              children: [
                Container(
                  child: tabs(value),
                  // color: Theme.of(context).cardColor,
                )
                ,Expanded(
                    child: tabBarView(value)
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget tabs(ProjectNotifier notifier){
    return TabBar(
      unselectedLabelColor: Colors.black,
      labelColor: Colors.blue,
      isScrollable: true,
      controller: notifier.tabController,
      //todo 第二层渲染 需要声明类型 泛型 避免 type 'List<dynamic>' is not a subtype of type 'List<Widget>'
      tabs: notifier.categoryList.map<Widget>((e) {
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
      children: notifier.categoryList.map<Widget>((e) {
        return ProjectInfoPage(e.id);
      }).toList(),
    );
  }
}



