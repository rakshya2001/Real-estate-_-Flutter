// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postedby_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostedByModal _$PostedByModalFromJson(Map<String, dynamic> json) =>
    PostedByModal(
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      email: json['email'] as String?,
      profile: json['profile'] as String?,
      id: json['id'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$PostedByModalToJson(PostedByModal instance) =>
    <String, dynamic>{
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'profile': instance.profile,
      'id': instance.id,
      'username': instance.username,
    };
