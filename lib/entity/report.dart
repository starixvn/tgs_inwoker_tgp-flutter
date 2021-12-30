import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/status.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  Report(
      this.id, this.createdOn, this.updatedOn, this.status, this.amount, this.canUploadCerts, this.orderNo);

  String? id;
  @JsonKey(name: 'createdon')
  String createdOn;
  String? updatedOn;
  Status status;
  double? amount;
  @JsonKey(name: 'canuploadcerts')
  bool? canUploadCerts;
  @JsonKey(name: 'orderno')
  String? orderNo;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
