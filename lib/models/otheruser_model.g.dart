// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otheruser_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserModal _$OtherUserModalFromJson(Map<String, dynamic> json) =>
    OtherUserModal(
      id: json['_id'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      profile: json['profile'] as String?,
      username: json['username'] as String?,
      followings: (json['following'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OtherUserModalToJson(OtherUserModal instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'username': instance.username,
      'following': instance.followings,
      'profile': instance.profile,
      'followers': instance.followers,
    };
