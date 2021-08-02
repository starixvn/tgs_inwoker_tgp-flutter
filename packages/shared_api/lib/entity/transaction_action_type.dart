import 'package:json_annotation/json_annotation.dart';

enum TransactionActionType{
  @JsonValue(0) ALL,
  @JsonValue(3) BONUS,
  @JsonValue(4) TRANSFER_IN,
  @JsonValue(5) TRANSFER_OUT,
  @JsonValue(6) ADJUST,
  @JsonValue(14) BET,
  @JsonValue(15) SUMMARY,
  @JsonValue(99) WITHDRAW,
  @JsonValue(100) DEPOSIT
}

extension TransactionActionTypeExtension on TransactionActionType {

  static const name = {
    TransactionActionType.ALL:  "全部",
    TransactionActionType.BONUS: "红利",
    TransactionActionType.TRANSFER_IN: "转入",
    TransactionActionType.TRANSFER_OUT: "转出",
    TransactionActionType.ADJUST: "调账",
    TransactionActionType.BET: "投注",
    TransactionActionType.SUMMARY: "结算",
    TransactionActionType.WITHDRAW: "提款",
    TransactionActionType.DEPOSIT: "存款",
  };

  static const jsonValue = {
    TransactionActionType.ALL:  "0",
    TransactionActionType.BONUS: "3",
    TransactionActionType.TRANSFER_IN: "4",
    TransactionActionType.TRANSFER_OUT: "5",
    TransactionActionType.ADJUST: "6",
    TransactionActionType.BET: "14",
    TransactionActionType.SUMMARY: "15",
    TransactionActionType.WITHDRAW: "99",
    TransactionActionType.DEPOSIT: "100",
  };

  String get displayName => name[this];
  String get getJsonValue => jsonValue[this];

}