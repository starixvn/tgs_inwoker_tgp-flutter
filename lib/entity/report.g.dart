// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      json['id'] as String?,
      json['createdon'] as String,
      json['updatedOn'] as String?,
      $enumDecode(_$StatusEnumMap, json['status']),
      (json['amount'] as num?)?.toDouble(),
      json['canuploadcerts'] as bool?,
      json['orderno'] as String?,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'createdon': instance.createdOn,
      'updatedOn': instance.updatedOn,
      'status': _$StatusEnumMap[instance.status],
      'amount': instance.amount,
      'canuploadcerts': instance.canUploadCerts,
      'orderno': instance.orderNo,
    };

const _$StatusEnumMap = {
  Status.All: 'All',
  Status.WaitingPayment: 1,
  Status.Review: 2,
  Status.Approved: 3,
  Status.Rejected: 4,
  Status.WaitingPaid: 5,
  Status.Paid: 6,
};
