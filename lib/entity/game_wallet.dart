import 'package:json_annotation/json_annotation.dart';
part 'game_wallet.g.dart';
@JsonSerializable()

class GameWallet {
  GameWallet();

  double balance;

  factory GameWallet.fromJson(Map<String, dynamic> json) => _$GameWalletFromJson(json);
  Map<String, dynamic> toJson() => _$GameWalletToJson(this);
}