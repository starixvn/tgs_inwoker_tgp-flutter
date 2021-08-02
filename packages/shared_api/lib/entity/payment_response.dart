import 'package:shared_api/entity/payment.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order.dart';
part 'payment_response.g.dart';

@JsonSerializable()

class PaymentResponse {
  PaymentResponse();

  Order order;
  List<Payment> payments;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) => _$PaymentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}