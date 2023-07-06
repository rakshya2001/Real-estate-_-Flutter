// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OtherUserResp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUserResp _$OtherUserRespFromJson(Map<String, dynamic> json) =>
    OtherUserResp(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OtherUserModal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OtherUserRespToJson(OtherUserResp instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
