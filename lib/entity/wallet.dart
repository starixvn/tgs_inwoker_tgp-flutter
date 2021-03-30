import 'package:json_annotation/json_annotation.dart';
part 'wallet.g.dart';
@JsonSerializable()

class Wallet {
  Wallet();

  int id;
  @JsonKey(name: 'parent_id')
  int parentId;
  String code;
  String name;
  int type;
  @JsonKey(name: 'pnl_ratio')
  String pnlRatio;
  @JsonKey(name: 'purse_type')
  int purseType;
  int status;
  @JsonKey(name: 'short_name')
  String shortName;
  int maintenance;
  @JsonKey(name: 'old_id')
  int oldId;
  int timezone;
  dynamic balance;
  @JsonKey(name: 'money_limit')
  dynamic moneyLimit;
  bool moneyLimitStatus;

  
  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}