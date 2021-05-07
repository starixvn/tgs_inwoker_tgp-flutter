import 'package:tgp_flutter/entity/bank_detail.dart';
import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bank_extended_info.g.dart';

@JsonSerializable()

class BankExtendedInfo {
  BankExtendedInfo();

  String name;
  String bankAccount;

  factory BankExtendedInfo.fromJson(Map<String, dynamic> json) => _$BankExtendedInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BankExtendedInfoToJson(this);

}
