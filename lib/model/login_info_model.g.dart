// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfoModel _$LoginInfoModelFromJson(Map<dynamic, dynamic> json) =>
    LoginInfoModel(
      json['admin'] as bool,
      json['chapterTops'] as List<dynamic>,
      json['coinCount'] as int,
      (json['collectIds'] as List<dynamic>).map((e) => e as int).toList(),
      json['email'] as String,
      json['icon'] as String,
      json['id'] as int,
      json['nickname'] as String,
      json['password'] as String,
      json['publicName'] as String,
      json['token'] as String,
      json['type'] as int,
      json['username'] as String,
    );

Map<dynamic, dynamic> _$LoginInfoModelToJson(LoginInfoModel instance) =>
    <dynamic, dynamic>{
      'admin': instance.admin,
      'chapterTops': instance.chapterTops,
      'coinCount': instance.coinCount,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'nickname': instance.nickname,
      'password': instance.password,
      'publicName': instance.publicName,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username,
    };
