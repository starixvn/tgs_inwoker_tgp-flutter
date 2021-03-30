
import 'package:tgp_flutter/entity/payment.dart';

class PaymentChannel {
  PaymentChannel(
  String key,
  String title,
  List<Payment> paymentList
  ){
    this.key = key;
    this.title = title;
    this.paymentList = paymentList;
  }

  String key;
  String title;
  List<Payment> paymentList;

  //factory PaymentChannel.map(Map<String, dynamic> json) => _map(json);
}

/*PaymentChannel _map(Map<String, dynamic> json) {
  return PaymentChannel()
    ..key = json.keys as String
    ..title = json.values.first.title as String
    ..paymentList = (json.values as List)
        ?.map((e) =>
    e == null ? null : Payment.fromJson(e as Map<String, dynamic>))
        ?.toList();
}*/

