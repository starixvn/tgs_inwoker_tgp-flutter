import 'package:json_annotation/json_annotation.dart';

part 'manual_deposit_order.g.dart';

@JsonSerializable()
class ManualDepositOrder {
  ManualDepositOrder(
      this.methodName, this.channelName, this.amount, this.bankName, this.bankAccountName, this.bankAccount);

  @JsonKey(name: "methodname")
  String methodName;
  @JsonKey(name: "channelname")
  String channelName;
  double amount;
  @JsonKey(name: "bankname")
  String bankName;
  @JsonKey(name: "bankaccountname")
  String bankAccountName;
  @JsonKey(name: "bankaccount")
  String bankAccount;
  @JsonKey(name: "qrcode")
  String? qrCode;

  factory ManualDepositOrder.fromJson(Map<String, dynamic> json) => _$ManualDepositOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ManualDepositOrderToJson(this);
}
