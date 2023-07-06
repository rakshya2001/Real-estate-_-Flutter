
import 'package:json_annotation/json_annotation.dart';

part 'postedby_model.g.dart';
@JsonSerializable()
class PostedByModal {
  String? fname;
  String? lname;
  String? email;
  String? profile;
  String? id;
  String? username;

  PostedByModal({
    this.fname,
    this.lname,
    this.email,
    this.profile,
    this.id,
    this.username,
  });

  factory PostedByModal.fromJson(Map<String, dynamic> json) =>
      _$PostedByModalFromJson(json);

  Map<String, dynamic> toJson() => _$PostedByModalToJson(this);
}
