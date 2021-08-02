import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:shared_api/entity/language.dart';
import 'package:shared_api/network/event_result.dart';
import 'package:shared_api/repository/base_repository.dart';
import 'package:shared_api/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo];

  getApiError() async {
    await userRepo.getApiErrorLocalization();
  }
}
