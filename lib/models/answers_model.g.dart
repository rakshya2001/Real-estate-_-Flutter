// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answers _$AnswersFromJson(Map<String, dynamic> json) => Answers(
      text: json['text'] as String?,
      answeredOn: json['answeredOn'] as String?,
      answeredBy: json['answeredBy'] as String?,
    );

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'text': instance.text,
      'answeredOn': instance.answeredOn,
      'answeredBy': instance.answeredBy,
    };
