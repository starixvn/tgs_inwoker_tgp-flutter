import 'package:tgp_flutter/entity/url.dart';

import 'package:json_annotation/json_annotation.dart';

part 'live_chat.g.dart';

@JsonSerializable()
class LiveChat {
  LiveChat(this.name, this.setting);

  String? name;
  Url? setting;

  factory LiveChat.fromJson(Map<String, dynamic> json) => _$LiveChatFromJson(json);

  Map<String, dynamic> toJson() => _$LiveChatToJson(this);
}
