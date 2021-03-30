import 'package:tgp_flutter/entity/payment_bank.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment.g.dart';

@JsonSerializable()

class Payment {
  Payment();

  int id;
  @JsonKey(name: "payment_id")
  int paymentId;
  String title;
  int min;
  int max;
  dynamic fee;
  @JsonKey(name: 'type_title')
  String typeTitle;
  @JsonKey(name: 'type_class')
  String typeClass;
  List<PaymentBank> banks;
  @JsonKey(name: 'amount_options')
  List<int> amountOptions;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}