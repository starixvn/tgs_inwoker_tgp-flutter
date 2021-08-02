import 'package:shared_api/entity/bank_detail.dart';
import 'package:shared_api/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_api/entity/localization.dart';
part 'announcement.g.dart';

@JsonSerializable()

class Announcement {
  Announcement();

  String subject;
  String content;
  int from;
  int to;
  Localization localization;

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

}