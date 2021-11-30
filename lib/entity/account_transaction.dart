import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/entity/status.dart';

part 'account_transaction.g.dart';

@JsonSerializable()
class AccountTransaction {
  AccountTransaction(
      this.id, this.createdOn, this.updatedOn, this.status, this.amount, this.canUploadCerts, this.orderNo);

  String id;
  @JsonKey(name: 'createdon')
  String createdOn;
  String updatedOn;
  Status status;
  double amount;
  @JsonKey(name: 'canuploadcerts')
  bool canUploadCerts;
  @JsonKey(name: 'orderno')
  String orderNo;

  factory AccountTransaction.fromJson(Map<String, dynamic> json) => _$AccountTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$AccountTransactionToJson(this);
}
