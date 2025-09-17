// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: UserModel._idFromJson(json['_id']),
  name: json['name'] as String,
  email: json['email'] as String,
  avatarId: (json['avaterId'] as num?)?.toInt(),
  phone: json['phone'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  photoUrl: json['photoUrl'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  '_id': UserModel._idToJson(instance.id),
  'name': instance.name,
  'email': instance.email,
  'avaterId': instance.avatarId,
  'phone': instance.phone,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'photoUrl': instance.photoUrl,
};
