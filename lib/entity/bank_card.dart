import 'package:tgp_flutter/entity/bank_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bank_card.g.dart';

@JsonSerializable()

class BankCard {
  BankCard();

  int id;
  @JsonKey(name: "bank_name")
  String bankName;
  @JsonKey(name: "bank_account")
  String bankAccount;
  @JsonKey(name: "is_default")
  int isDefault;

  factory BankCard.fromJson(Map<String, dynamic> json) => _$BankCardFromJson(json);
  Map<String, dynamic> toJson() => _$BankCardToJson(this);


  String getDisplayString(){
    return "$bankName - $bankAccount";
  }

  BankType getBankType(){
    return BankType.values.singleWhere((e) => e.displayName == bankName);
  }

  String getImagePath(){
    return getBankType()?.getImagePath;
  }
}