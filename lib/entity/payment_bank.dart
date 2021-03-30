import 'package:json_annotation/json_annotation.dart';
part 'payment_bank.g.dart';

@JsonSerializable()

class PaymentBank {
  PaymentBank();

  String id;
  String title;
  @JsonKey(name: 'bank_name')
  String bankName;

  factory PaymentBank.fromJson(Map<String, dynamic> json) => _$PaymentBankFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentBankToJson(this);
}