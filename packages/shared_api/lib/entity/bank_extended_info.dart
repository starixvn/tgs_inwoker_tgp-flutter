import 'package:shared_api/entity/bank_detail.dart';
import 'package:shared_api/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bank_extended_info.g.dart';

@JsonSerializable()

class BankExtendedInfo {
  BankExtendedInfo();

  String channel;
  String systemId;
  String systemKey;
  String channelCurrency;

  factory BankExtendedInfo.fromJson(Map<String, dynamic> json) => _$BankExtendedInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BankExtendedInfoToJson(this);

}