import 'package:tgp_flutter/entity/wallet.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wallet_response.g.dart';
@JsonSerializable()

class WalletResponse {
  WalletResponse();

  @JsonKey(name: "thirdpartys")
  List<Wallet> walletList;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => _$WalletResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WalletResponseToJson(this);
}