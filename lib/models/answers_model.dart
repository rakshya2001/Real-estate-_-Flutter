import 'package:json_annotation/json_annotation.dart';

part 'answers_model.g.dart';

@JsonSerializable()
class Answers {
  String? text;
  String? answeredOn;
  String? answeredBy;
  
  
  Answers({
    this.text, 
    this.answeredOn,
    this.answeredBy 
  });

  factory Answers.fromJson(Map<String, dynamic> json) =>
      _$AnswersFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersToJson(this);
}
