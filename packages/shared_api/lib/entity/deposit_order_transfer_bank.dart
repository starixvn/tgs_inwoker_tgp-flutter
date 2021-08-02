import 'package:json_annotation/json_annotation.dart';
part 'deposit_order_transfer_bank.g.dart';

@JsonSerializable()

class DepositOrderTransferBank {
  DepositOrderTransferBank();

  @JsonKey(name: "is_qrcode")
  int isQrcode;
  @JsonKey(name: "is_transfer")
  int isTransfer;
  @JsonKey(name: 'bank_name')
  String bankName;
  @JsonKey(name: 'card_number')
  String cardNumber;
  @JsonKey(name: 'card_ch_name')
  String cardChName;
  @JsonKey(name: 'card_pro')
  String cardPro;
  @JsonKey(name: "card_city")
  String cardCity;
  @JsonKey(name: 'card_bank_name')
  String cardBankName;

  factory DepositOrderTransferBank.fromJson(Map<String, dynamic> json) => _$DepositOrderTransferBankFromJson(json);
  Map<String, dynamic> toJson() => _$DepositOrderTransferBankToJson(this);
}