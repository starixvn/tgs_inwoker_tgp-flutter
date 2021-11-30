import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';

enum Status {
  All,
  @JsonValue(1)
  WaitingPayment,
  @JsonValue(2)
  Review,
  @JsonValue(3)
  Approved,
  @JsonValue(4)
  Rejected,
  @JsonValue(5)
  WaitingPaid,
  @JsonValue(6)
  Paid,
}

extension StatusExtension on Status {
  String getName(BuildContext context) {
    switch (this) {
      case Status.WaitingPayment:
        return getTranslatedText(context, "waiting_payment");
      case Status.Review:
        return getTranslatedText(context, "review");
      case Status.Approved:
        return getTranslatedText(context, "approved");
      case Status.Rejected:
        return getTranslatedText(context, "rejected");
      case Status.WaitingPaid:
        return getTranslatedText(context, "waiting_paid");
      case Status.Paid:
        return getTranslatedText(context, "paid");
      case Status.All:
        return getTranslatedText(context, "all");
      default:
        return "";
    }
  }

  int getJson() {
    switch (this) {
      case Status.WaitingPayment:
        return 1;
      case Status.Review:
        return 2;
      case Status.Approved:
        return 3;
      case Status.Rejected:
        return 4;
      case Status.WaitingPaid:
        return 5;
      case Status.Paid:
        return 6;
      case Status.All:
      default:
        return 1;
    }
  }

  getTranslatedText(BuildContext context, String key) => LanguageProvider().getTranslated(context, key);
}
