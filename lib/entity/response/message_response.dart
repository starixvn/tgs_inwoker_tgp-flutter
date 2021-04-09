
import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/message.dart';
part 'message_response.g.dart';

@JsonSerializable()

class MessageResponse {
  MessageResponse(this.code, this.msg, this.totalCount, this.items);

  @JsonKey(name: 'err')
  int code;
  @JsonKey(name: 'errmsg')
  String msg;
  @JsonKey(name: 'totalcount')
  int totalCount;
  List<Message> items;

  factory MessageResponse.fromJson(Map<String, dynamic> json) => _$MessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}
