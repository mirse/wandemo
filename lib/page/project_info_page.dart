import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wandemo/controller/project_info_controller.dart';
import 'package:wandemo/notifier/project_info_notifier.dart';

class ProjectInfoPage extends StatelessWidget {
    final int cid;
    //late ProjectInfoController controller;

    ProjectInfoPage(this.cid){
       // Get.put<ProjectInfoController>(ProjectInfoController(),tag: cid.toString());
       // controller =Get.find<ProjectInfoController>(tag: cid.toString());
       // controller.getArticle(cid, 0);
    }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => ProjectInfoNotifier(cid),
        child: Consumer<ProjectInfoNotifier>(
          builder: (BuildContext context, value, Widget? child) {
            return Container(
                padding: EdgeInsets.all(3),
                child: GridView.count(
                  controller: value.scrollController,
                  crossAxisCount: 2,
                  children:gridItemList(context,value),
                  childAspectRatio: 3/4,//宽高比
                  mainAxisSpacing: 5.0,//纵轴间隙
                  crossAxisSpacing: 5.0,//横轴间隙
                )
            );
          },
        ),
    );
  }



  List<Widget> gridItemList(ctx,projectInfoNotifier){
    List<Widget> list = projectInfoNotifier.projectInfoList.map<Widget>((e){
      return GestureDetector(
        child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Column(
                children: [
                  Image.network(e.envelopePic,height: 150,width:double.infinity,fit: BoxFit.cover,),
                  SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(e.desc,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Author:${e.author}',maxLines: 1,overflow: TextOverflow.ellipsis,),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
        onTap: (){
          // Get.toNamed('/articleInfo',arguments: {'link':e.link,'title':e.title});
          Navigator.of(ctx).pushNamed('/articleInfo',
              arguments: {'link':e.link,'title':e.title}
          );
        },
      );
    }).toList();
    return list;
  }
}
