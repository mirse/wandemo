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
import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';


@JsonSerializable()
class BannerModel{

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imagePath')
  String imagePath;

  @JsonKey(name: 'isVisible')
  int isVisible;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'url')
  String url;

  BannerModel(this.desc,this.id,this.imagePath,this.isVisible,this.order,this.title,this.type,this.url,);

  factory BannerModel.fromJson(Map<String, dynamic> srcJson) => _$BannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

}







