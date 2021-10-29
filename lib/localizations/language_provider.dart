import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/repository/content_repository.dart';

import 'my_localizations.dart';

class LanguageProvider {
  List<Language>  list = [];
  final contentRepo = ContentRepository.getSingleton();

  Map<String, Language> languageList = {
    "en-US": Language("en", "English", Locale("en", ''), "en-US", "images/language/ic_lang_en.png"),
    "zh-CN": Language("zh_Hans", "简体中文", Locale.fromSubtags(languageCode: "zh", scriptCode: "Hans"), "zh-CN",
        "images/language/ic_lang_zh.png"),
    "zh-TW": Language("zh_Hant", "繁体中文", Locale.fromSubtags(languageCode: "zh", scriptCode: "Hant"), "zh-TW",
        "images/language/ic_lang_zh_tw.png"),
    "th-TH": Language("th-TH", "ไทย", Locale("th", ""), "th-TH", "images/language/ic_lang_th.png"),
    "id-ID": Language("id-ID", "Indonesia", Locale("id", ''), "id-ID", "images/language/ic_lang_en.png"),
    "vi-VN": Language("vi-VN", "Tiếng Việt", Locale("vi", ''), "vi-VN", "images/language/ic_lang_en.png"),
  };

  LanguageProvider() {
    var languageOptionList = contentRepo.languageOptionList;
    /*if(languageOptionList == null){
      contentRepo.getLanguageOption().then((list) =>
      languageOptionList = list.result);
    }
    if (languageOptionList?.isEmpty ?? true) {
      list.add(languageList["zh-CN"]);
    } else {*/
      languageOptionList.forEach((languageOption) {
        var code = languageOption.code;
        languageList.forEach((key, value) {
          if (key == code) {
            list.add(value);
          }
        });
      });
    //}
  }

  /*var list=[
    Language("en","English", Locale("en", ''), "en-US","images/language/ic_lang_en.png"),
    Language("zh_Hans","简体中文", Locale.fromSubtags(languageCode: "zh", scriptCode: "Hans"), "zh-CN","images/language/ic_lang_zh.png"),
    Language("zh_Hant","繁体中文", Locale.fromSubtags(languageCode: "zh", scriptCode: "Hant"), "zh-TW","images/language/ic_lang_zh_tw.png"),
  ];*/

  Future<Locale> setLocale(Language language) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("LANGUAGE_CODE", language.apiCode);
    return _locale(language);
  }

  Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString("LANGUAGE_CODE");
    return _locale(languageCode != null ? list.singleWhere((e) => e.apiCode == languageCode) : null);
  }

  Locale _locale(Language language) {
    if (language == null) {
      return null;
    } else {
      return language.locale;
    }
  }

  String getTranslated(BuildContext context, String key) {
    return MyLocalizations.of(context).translate(key);
  }
}
