
import 'package:json_annotation/json_annotation.dart';

part 'otheruser_model.g.dart';
@JsonSerializable()
class OtherUserModal {
  @JsonKey(name: '_id')
  String? id;
  String? fname;
  String? lname;
  String? username;
  String? profile;
  List<String>? followings;
  List<String>? followers;
  OtherUserModal({
    this.id,
    this.fname,
    this.lname,
    this.username,
    this.followings,
    this.followers,
    this.profile,
  });

  factory OtherUserModal.fromJson(Map<String, dynamic> json) =>
      _$OtherUserModalFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserModalToJson(this);
}
