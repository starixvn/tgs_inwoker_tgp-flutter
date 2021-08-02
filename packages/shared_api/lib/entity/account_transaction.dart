import 'package:json_annotation/json_annotation.dart';
import 'package:shared_api/entity/status.dart';
part 'account_transaction.g.dart';

@JsonSerializable()

class AccountTransaction {
  AccountTransaction();

  String id;
  @JsonKey(name: 'createdon')
  String createdOn;
  String updatedOn;
  Status status;
  double amount;

  factory AccountTransaction.fromJson(Map<String, dynamic> json) => _$AccountTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$AccountTransactionToJson(this);
}
