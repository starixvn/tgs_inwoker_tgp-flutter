import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';

enum BankType {
  @JsonValue("Bank")
  BANK,
  @JsonValue("Crypto")
  CRYPTO,
  @JsonValue("ThirdParty")
  THIRD_PARTY,
  FPS,
}

extension BankTypeExtension on BankType {
  static const json = {
    BankType.BANK: "Bank",
    BankType.CRYPTO: "Crypto",
    BankType.THIRD_PARTY: "ThirdParty",
    BankType.FPS: "FPS",
  };

  String? get getJson => json[this];

  String getName(BuildContext context) {
    switch (this) {
      case BankType.BANK:
        return getTranslatedText(context, "bank_transfer");
      case BankType.CRYPTO:
        return getTranslatedText(context, "crypto");
      case BankType.THIRD_PARTY:
        return "Third Party";
      case BankType.FPS:
        return "FPS";
      default:
        return "";
    }
  }

  getTranslatedText(BuildContext context, String key) => LanguageProvider().getTranslated(context, key);
}
