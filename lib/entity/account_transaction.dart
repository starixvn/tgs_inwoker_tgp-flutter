import 'package:json_annotation/json_annotation.dart';
part 'account_transaction.g.dart';

@JsonSerializable()

class AccountTransaction {
  AccountTransaction();

  int id;
  String sn;
  @JsonKey(name: "member_id")
  String memberId;
  String amount;
  String balance;
  @JsonKey(name: "method_type")
  int methodType;
  @JsonKey(name: "action_type")
  int actionType;
  @JsonKey(name: "action_time")
  String actionTime;
  @JsonKey(name: "action_ip")
  String actionIp;
  String note;
  @JsonKey(name: "error_note")
  String errorNote;
  @JsonKey(name: "related_id")
  int relatedId;
  int status;
  @JsonKey(name: "member_bank_id")
  int memberBankId;
  @JsonKey(name: "thirdparty_parent_id")
  int thirdpartyParentId;
  @JsonKey(name: "thirdparty_id")
  int thirdpartyId;
  @JsonKey(name: "turnover_multiple")
  String turnoverMultiple;
  @JsonKey(name: "turnover_method_type")
  int turnoverMethodType;
  @JsonKey(name: "turnover_method_num")
  String turnoverMethodNum;
  @JsonKey(name: "turnover_num")
  String turnoverNum;
  @JsonKey(name: "turnover_platform")
  int turnoverPlatform;
  @JsonKey(name: "commission_calc")
  int commissionCalc;
  @JsonKey(name: "audit_user")
  String auditUser;
  @JsonKey(name: "audit_time")
  int auditTime;
  @JsonKey(name: "audit_reason")
  String auditReason;
  @JsonKey(name: "thirdparty_name")
  String thirdpartyName;
  @JsonKey(name: "action_type_str")
  String actionTypeStr;
  @JsonKey(name: "status_str")
  String statusStr;
  @JsonKey(name: "from_to")
  String fromTo;

  factory AccountTransaction.fromJson(Map<String, dynamic> json) => _$AccountTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$AccountTransactionToJson(this);
}
