import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:api/entity/language.dart';
import 'package:api/network/event_result.dart';
 import 'package:api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo];

  getApiError() async {
    await userRepo.getApiErrorLocalization();
  }
}
