import 'package:json_annotation/json_annotation.dart';
import 'package:sparrow/models/answers_model.dart';
import 'package:sparrow/models/postedby_model.dart';
part 'question_model.g.dart';

@JsonSerializable()
class Questions {
  @JsonKey(name: '_id')
  String? id;
  String? questionName;
  String? questionImage;
  String? createdAt;
  PostedByModal? postedBy;
  List<Answers>? answers;
  List<String>? likes;

  Questions({
    this.id,
    this.questionName,
    this.questionImage,
    this.createdAt,
    this.postedBy,
    this.answers,
    this.likes,
  });

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}
