// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_order_transfer_bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositOrderTransferBank _$DepositOrderTransferBankFromJson(
    Map<String, dynamic> json) {
  return DepositOrderTransferBank()
    ..isQrcode = json['is_qrcode'] as int
    ..isTransfer = json['is_transfer'] as int
    ..bankName = json['bank_name'] as String
    ..cardNumber = json['card_number'] as String
    ..cardChName = json['card_ch_name'] as String
    ..cardPro = json['card_pro'] as String
    ..cardCity = json['card_city'] as String
    ..cardBankName = json['card_bank_name'] as String;
}

Map<String, dynamic> _$DepositOrderTransferBankToJson(
        DepositOrderTransferBank instance) =>
    <String, dynamic>{
      'is_qrcode': instance.isQrcode,
      'is_transfer': instance.isTransfer,
      'bank_name': instance.bankName,
      'card_number': instance.cardNumber,
      'card_ch_name': instance.cardChName,
      'card_pro': instance.cardPro,
      'card_city': instance.cardCity,
      'card_bank_name': instance.cardBankName,
    };
