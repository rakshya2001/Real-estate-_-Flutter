// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questions _$QuestionsFromJson(Map<String, dynamic> json) => Questions(
      id: json['_id'] as String?,
      questionName: json['questionName'] as String?,
      questionImage: json['questionImage'] as String?,
      createdAt: json['createdAt'] as String?,
      postedBy: json['postedBy'] == null
          ? null
          : PostedByModal.fromJson(json['postedBy'] as Map<String, dynamic>),
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => Answers.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      '_id': instance.id,
      'questionName': instance.questionName,
      'questionImage': instance.questionImage,
      'createdAt': instance.createdAt,
      'postedBy': instance.postedBy,
      'answers': instance.answers,
      'likes': instance.likes,
    };
