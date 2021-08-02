import 'package:json_annotation/json_annotation.dart';

enum TransactionStatusType{
@JsonValue(0) ALL,
@JsonValue(1) SUCESS,
@JsonValue(2) VERIFYING,
@JsonValue(3) CANCELED,
@JsonValue(4) FAIL,
}

extension TransactionStatusTypeExtension on TransactionStatusType {

  static const name = {
    TransactionStatusType.ALL:  "全部",
    TransactionStatusType.SUCESS:  "成功",
    TransactionStatusType.VERIFYING:  "审核中",
    TransactionStatusType.CANCELED:  "已取消",
    TransactionStatusType.FAIL:  "失败",

  };

  static const jsonValue = {
    TransactionStatusType.ALL:  "0",
    TransactionStatusType.SUCESS:  "1",
    TransactionStatusType.VERIFYING:  "2",
    TransactionStatusType.CANCELED:  "3",
    TransactionStatusType.FAIL:  "4"
  };

  String get displayName => name[this];
  String get getJsonValue => jsonValue[this];

}