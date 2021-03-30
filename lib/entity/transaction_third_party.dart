import 'package:tgp_flutter/entity/deposit_response.dart';
import 'package:tgp_flutter/entity/transaction_third_party_type.dart';
import 'package:json_annotation/json_annotation.dart';

class TransactionThirdParty {
  TransactionThirdParty(
      this.id,
      this.name
      );

  int id;
  String name;

}