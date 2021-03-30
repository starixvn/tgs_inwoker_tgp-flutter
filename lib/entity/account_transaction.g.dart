// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountTransaction _$AccountTransactionFromJson(Map<String, dynamic> json) {
  return AccountTransaction()
    ..id = json['id'] as int
    ..sn = json['sn'] as String
    ..memberId = json['member_id'] as String
    ..amount = json['amount'] as String
    ..balance = json['balance'] as String
    ..methodType = json['method_type'] as int
    ..actionType = json['action_type'] as int
    ..actionTime = json['action_time'] as String
    ..actionIp = json['action_ip'] as String
    ..note = json['note'] as String
    ..errorNote = json['error_note'] as String
    ..relatedId = json['related_id'] as int
    ..status = json['status'] as int
    ..memberBankId = json['member_bank_id'] as int
    ..thirdpartyParentId = json['thirdparty_parent_id'] as int
    ..thirdpartyId = json['thirdparty_id'] as int
    ..turnoverMultiple = json['turnover_multiple'] as String
    ..turnoverMethodType = json['turnover_method_type'] as int
    ..turnoverMethodNum = json['turnover_method_num'] as String
    ..turnoverNum = json['turnover_num'] as String
    ..turnoverPlatform = json['turnover_platform'] as int
    ..commissionCalc = json['commission_calc'] as int
    ..auditUser = json['audit_user'] as String
    ..auditTime = json['audit_time'] as int
    ..auditReason = json['audit_reason'] as String
    ..thirdpartyName = json['thirdparty_name'] as String
    ..actionTypeStr = json['action_type_str'] as String
    ..statusStr = json['status_str'] as String
    ..fromTo = json['from_to'] as String;
}

Map<String, dynamic> _$AccountTransactionToJson(AccountTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sn': instance.sn,
      'member_id': instance.memberId,
      'amount': instance.amount,
      'balance': instance.balance,
      'method_type': instance.methodType,
      'action_type': instance.actionType,
      'action_time': instance.actionTime,
      'action_ip': instance.actionIp,
      'note': instance.note,
      'error_note': instance.errorNote,
      'related_id': instance.relatedId,
      'status': instance.status,
      'member_bank_id': instance.memberBankId,
      'thirdparty_parent_id': instance.thirdpartyParentId,
      'thirdparty_id': instance.thirdpartyId,
      'turnover_multiple': instance.turnoverMultiple,
      'turnover_method_type': instance.turnoverMethodType,
      'turnover_method_num': instance.turnoverMethodNum,
      'turnover_num': instance.turnoverNum,
      'turnover_platform': instance.turnoverPlatform,
      'commission_calc': instance.commissionCalc,
      'audit_user': instance.auditUser,
      'audit_time': instance.auditTime,
      'audit_reason': instance.auditReason,
      'thirdparty_name': instance.thirdpartyName,
      'action_type_str': instance.actionTypeStr,
      'status_str': instance.statusStr,
      'from_to': instance.fromTo,
    };
