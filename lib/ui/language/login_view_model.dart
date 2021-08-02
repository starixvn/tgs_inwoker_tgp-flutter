import 'package:flutter/material.dart';
import 'package:tgp_flutter/base_viewmodel.dart';
import 'package:api_package/entity/language.dart';
import 'package:api_package/network/event_result.dart';
 import 'package:api_package/api_package.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageViewModel extends BaseViewModel {
  final userRepo = UserRepository.getSingleton();

  @override
  List<BaseRepository> get repoList => [userRepo];

  getApiError() async {
    await userRepo.getApiErrorLocalization();
  }
}
