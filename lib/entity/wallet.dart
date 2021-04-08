import 'package:json_annotation/json_annotation.dart';
part 'wallet.g.dart';
@JsonSerializable()

class Wallet {
  Wallet();

  double main;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}