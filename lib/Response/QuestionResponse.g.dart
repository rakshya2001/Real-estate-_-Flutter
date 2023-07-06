// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResponse _$QuestionResponseFromJson(Map<String, dynamic> json) =>
    QuestionResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Questions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionResponseToJson(QuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
