import 'package:shared_api/entity/deposit_response.dart';
import 'package:shared_api/entity/transaction_third_party_type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'third_party.g.dart';

@JsonSerializable()

class ThirdParty {
  ThirdParty(
      this.id,
      this.parentId,
      this.type,
      this.purseType,
      this.status,
      this.name
      );

  int id;
  @JsonKey(name: "parent_id")
  int parentId;
  TransactionThirdPartyType type;
  @JsonKey(name: "purse_type")
  int purseType;
  int status;
  String name;

  factory ThirdParty.fromJson(Map<String, dynamic> json) => _$ThirdPartyFromJson(json);
  Map<String, dynamic> toJson() => _$ThirdPartyToJson(this);
}