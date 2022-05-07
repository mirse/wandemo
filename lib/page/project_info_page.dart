import 'package:flutter/material.dart';
import 'package:wandemo/http/http_manager.dart';
import 'package:wandemo/model/project_info_model.dart';

class ProjectInfoPage extends StatefulWidget {
  final int cid;
  const ProjectInfoPage(this.cid,{Key? key}) : super(key: key);

  @override
  _ProjectInfoPageState createState() => _ProjectInfoPageState(cid);
}

class _ProjectInfoPageState extends State<ProjectInfoPage> with AutomaticKeepAliveClientMixin{
  final int _cid;
  int _page = 0;
  List<ProjectInfoModel> projectInfoList = [];
  ScrollController _controller = ScrollController();
  var loading = true;
  _ProjectInfoPageState(this._cid);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(3),
      child: GridView.count(
        controller: _controller,
        crossAxisCount: 2,
        children:_gridItemList,
        childAspectRatio: 3/4,//宽高比
        mainAxisSpacing: 5.0,//纵轴间隙
        crossAxisSpacing: 5.0,//横轴间隙
      )
    );
  }

  get _gridItemList{
    List<Widget> list = projectInfoList.map((e){
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
          Navigator.of(context).pushNamed('/articleInfo',
              arguments: {'link':e.link,'title':e.title}
          );
        },
      );
    }).toList();
    return list;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var distance = _controller.position.maxScrollExtent -
          _controller.position.pixels;
      if (distance<300 && !loading && _controller.position.maxScrollExtent != 0) {
        _page++;
        loading = true;
        _getArticle(_cid,_page);
      }
    });

    _getArticle(_cid, _page);

  }

  void _getArticle(cid,page){
    HttpManager().getProjectInfo(params: {
      'cid':cid,
      'page':page,
    },success: (data){
      setState(() {
        loading = false;
        projectInfoList.addAll(data);
      });
    },fail: (errorCode,msg){
      loading = false;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}
