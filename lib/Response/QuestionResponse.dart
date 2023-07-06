import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:sparrow/models/question_model.dart';

part 'QuestionResponse.g.dart';

@JsonSerializable()
class QuestionResponse {
  bool? success = true;
  List<Questions>? data;
  QuestionResponse( {this.data, this.success});

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}

// build runtime json serialization

