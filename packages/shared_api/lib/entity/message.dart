import 'package:json_annotation/json_annotation.dart';
import 'package:shared_api/entity/localization.dart';
part 'message.g.dart';
@JsonSerializable()

class Message {
  Message();

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'createon')
  String createdOn;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'subject')
  String subject;
  @JsonKey(name: 'isread')
  bool isRead;
  Localization localization;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}