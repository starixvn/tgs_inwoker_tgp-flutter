import 'package:json_annotation/json_annotation.dart';
import 'deposit_bonus.dart';
part 'deposit_bonus_group.g.dart';

@JsonSerializable()

class DepositBonusGroup {
  DepositBonusGroup(this.depositBonus, this.child);

  DepositBonus depositBonus;
  List<DepositBonus> child;

}
