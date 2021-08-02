import 'package:json_annotation/json_annotation.dart';

enum TransactionBetStatusType{
  @JsonValue(1) SETTLED,
  @JsonValue(2) UNSETTLEMENT,
}

extension TransactionBetStatusTypeExtension on TransactionBetStatusType {

  static const name = {
    TransactionBetStatusType.SETTLED:  "已结算",
    TransactionBetStatusType.UNSETTLEMENT:  "未结算",
  };

  static const jsonValue = {
    TransactionBetStatusType.SETTLED:  "1",
    TransactionBetStatusType.UNSETTLEMENT:  "2",
  };

  String get displayName => name[this];
  String get getJsonValue => jsonValue[this];

}