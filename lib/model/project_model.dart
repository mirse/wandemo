import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';


@JsonSerializable()
class ProjectModel extends Object {

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'lisense')
  String lisense;

  @JsonKey(name: 'lisenseLink')
  String lisenseLink;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'parentChapterId')
  int parentChapterId;

  @JsonKey(name: 'userControlSetTop')
  bool userControlSetTop;

  @JsonKey(name: 'visible')
  int visible;

  ProjectModel(this.author,this.children,this.courseId,this.cover,this.desc,this.id,this.lisense,this.lisenseLink,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible,);

  factory ProjectModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);

}


