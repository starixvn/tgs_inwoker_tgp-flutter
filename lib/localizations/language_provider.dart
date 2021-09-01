import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/entity/language.dart';
import 'package:tgp_flutter/repository/content_repository.dart';

import 'my_localizations.dart';

class LanguageProvider {
  var languageTextMap = {
    "en-US": "English",
    "zh-CN": "简体中文",
    "zh-TW": "繁体中文",
    "th-TH": "Thai",
    "id-ID":"Indonesia",
    "vi-VN":"Tiếng Việt"
  };
  List<Language> list = [];
  final contentRepo = ContentRepository.getSingleton();

  LanguageProvider() {
    var languageOptionList = contentRepo.languageOptionList;
    languageOptionList.forEach((languageOption) {
      var code = languageOption.code;
      var splitCode = code.split('-');
      if (code == "zh-CN") {
        list.add(Language("zh_Hans", "简体中文", Locale.fromSubtags(languageCode: "zh", scriptCode: "Hans"), "zh-CN",
            "images/language/ic_lang_zh.png"));
      } else if (code == "zh-TW") {
        list.add(Language("zh_Hant", "繁体中文", Locale.fromSubtags(languageCode: "zh", scriptCode: "Hant"), "zh-TW",
            "images/language/ic_lang_zh_tw.png"));
      } else if (code == "en-US") {
        list.add(
          Language("en", "English", Locale("en", ''), "en-US", "images/language/ic_lang_en.png"),
        );
      /* }else if (code == "vi-VN") {
        list.add(
          Language("vi", languageTextMap[code], Locale(splitCode[0], ''), "code", " "),
        );*/
      }else
        list.add(Language(splitCode[0], languageTextMap[code], Locale(splitCode[0],""), code,
            " "));
    });
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

  getCurrentLanguage(Locale _locale) {
    return list.singleWhere((e) => e.locale == _locale);
  }
}
