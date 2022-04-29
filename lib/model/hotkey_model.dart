import 'package:json_annotation/json_annotation.dart';

part 'hotkey_model.g.dart';

@JsonSerializable()
class HotkeyModel{

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  HotkeyModel(this.data,this.errorCode,this.errorMsg,);

  factory HotkeyModel.fromJson(Map<String, dynamic> srcJson) => _$HotkeyModelFromJson(srcJson);

}


@JsonSerializable()
class Data{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'visible')
  int visible;

  Data(this.id,this.link,this.name,this.order,this.visible,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}


