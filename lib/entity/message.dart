import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/localization.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message(this.id, this.createdOn, this.content, this.subject, this.isRead, this.localization);

  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'createon')
  String? createdOn;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'subject')
  String? subject;
  @JsonKey(name: 'isread')
  bool? isRead;
  Localization? localization;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
