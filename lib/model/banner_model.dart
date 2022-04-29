/**
 * {
    "data": [
    {
    "desc": "我们支持订阅啦~",
    "id": 30,
    "imagePath": "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
    "isVisible": 1,
    "order": 0,
    "title": "我们支持订阅啦~",
    "type": 0,
    "url": "https://www.wanandroid.com/blog/show/3352"
    },
    {
    "desc": "",
    "id": 6,
    "imagePath": "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
    "isVisible": 1,
    "order": 1,
    "title": "我们新增了一个常用导航Tab~",
    "type": 1,
    "url": "https://www.wanandroid.com/navi"
    },
    {
    "desc": "一起来做个App吧",
    "id": 10,
    "imagePath": "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
    "isVisible": 1,
    "order": 1,
    "title": "一起来做个App吧",
    "type": 1,
    "url": "https://www.wanandroid.com/blog/show/2"
    }
    ],
    "errorCode": 0,
    "errorMsg": ""
    }
 */
class BannerModel{
  final int errorCode;
  final String errorMsg;
  final List<Data> datas;

  BannerModel({required this.errorCode, required this.errorMsg,required this.datas});

  factory BannerModel.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['data'] as List;
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();
    return BannerModel(
        errorCode: parsedJson['errorCode'],
        errorMsg: parsedJson['errorMsg'],
        datas: dataList
    );
  }

  @override
  String toString() {
    return 'BannerModel{errorCode: $errorCode, errorMsg: $errorMsg, datas: $datas}';
  }
}

class Data{
  final String desc;
  final String imagePath;
  final String title;
  final String url;
  final int id;
  final int isVisible;
  final int order;
  final int type;

  Data({required this.desc,required this.imagePath,required this.title,required this.url,required this.id,required this.isVisible,
    required this.order,required this.type});

  factory Data.fromJson(Map<String, dynamic> parsedJson){
    return Data(
        desc: parsedJson['desc'],
        imagePath: parsedJson['imagePath'],
        title: parsedJson['title'],
        url: parsedJson['url'],
        id: parsedJson['id'],
        isVisible: parsedJson['isVisible'],
        order: parsedJson['order'],
        type: parsedJson['type'],
    );
  }

  @override
  String toString() {
    return 'Data{desc: $desc, imagePath: $imagePath, title: $title, url: $url, id: $id, isVisible: $isVisible, order: $order, type: $type}';
  }
}

