import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/localization.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  Announcement(this.subject, this.content, this.from, this.to, this.localization);

  String? subject;
  String? content;
  int from;
  int to;
  Localization? localization;

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
