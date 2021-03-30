import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';
@JsonSerializable()

class Message {
  Message();

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'content')
  String content;
  @JsonKey(name: 'created_time')
  String createdTime;
  @JsonKey(name: 'read_id')
  int readId;
  @JsonKey(name: 'is_read')
  int intIsRead;
  @JsonKey(name: 'is_admin_send')
  int isAdminSend;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}