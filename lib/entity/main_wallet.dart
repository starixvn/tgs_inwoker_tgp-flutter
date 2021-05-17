import 'package:json_annotation/json_annotation.dart';
part 'main_wallet.g.dart';
@JsonSerializable()

class MainWallet {
  MainWallet();

  double main;

  factory MainWallet.fromJson(Map<String, dynamic> json) => _$MainWalletFromJson(json);
  Map<String, dynamic> toJson() => _$MainWalletToJson(this);
}