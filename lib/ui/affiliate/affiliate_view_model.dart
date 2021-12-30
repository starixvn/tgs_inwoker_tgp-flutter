import 'package:flutter/cupertino.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:tgp_flutter/entity/report.dart';
import 'package:tgp_flutter/entity/account_report.dart';
import 'package:tgp_flutter/entity/promotion_report.dart';
import 'package:tgp_flutter/entity/transfer_report.dart';
import 'package:tgp_flutter/entity/game_provider.dart';
import 'package:tgp_flutter/entity/status.dart';
import 'package:tgp_flutter/extension/format.dart';
import 'package:tgp_flutter/network/event_result.dart';
import 'package:tgp_flutter/repository/bank_repository.dart';
import 'package:tgp_flutter/repository/base_repository.dart';
import 'package:tgp_flutter/repository/content_repository.dart';
import 'package:tgp_flutter/repository/user_repository.dart';

class AffiliateViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();

  get userProfile => userRepo.userProfile;


  @override
  List<BaseRepository> get repoList => [userRepo,];


}
