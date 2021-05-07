import 'package:json_annotation/json_annotation.dart';
enum BankType {
  @JsonValue("Bank")
  BANK,
  @JsonValue("Crypto")
  CRYPTO
}

extension BankTypeExtension on BankType {
  static const name = {
    BankType.BANK: "Bank",
    BankType.CRYPTO: "Crypto",
  };

  String get displayName => name[this];
}
