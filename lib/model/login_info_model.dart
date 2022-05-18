import 'package:json_annotation/json_annotation.dart';

part 'login_info_model.g.dart';


@JsonSerializable()
class LoginInfoModel extends Object {

  @JsonKey(name: 'admin')
  bool admin;

  @JsonKey(name: 'chapterTops')
  List<dynamic> chapterTops;

  @JsonKey(name: 'coinCount')
  int coinCount;

  @JsonKey(name: 'collectIds')
  List<int> collectIds;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'publicName')
  String publicName;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'username')
  String username;

  LoginInfoModel(this.admin,this.chapterTops,this.coinCount,this.collectIds,this.email,this.icon,this.id,this.nickname,this.password,this.publicName,this.token,this.type,this.username,);

  factory LoginInfoModel.fromJson(Map<dynamic, dynamic> srcJson) => _$LoginInfoModelFromJson(srcJson);

  Map<dynamic, dynamic> toJson() => _$LoginInfoModelToJson(this);

}


