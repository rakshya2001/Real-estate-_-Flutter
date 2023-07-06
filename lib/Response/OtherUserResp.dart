import 'dart:collection';
import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:sparrow/models/otheruser_model.dart';


part 'OtherUserResp.g.dart';

@JsonSerializable()
class OtherUserResp {
  bool? success;
  List<OtherUserModal>? data;
  OtherUserResp( {
    this.success,
    this.data
  });

  factory OtherUserResp.fromJson(Map<String, dynamic> json) =>
      _$OtherUserRespFromJson(json);

  Map<String, dynamic> toJson() => _$OtherUserRespToJson(this);
}

// build runtime json serialization

