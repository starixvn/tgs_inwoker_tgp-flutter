import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;
  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  Map<String, String> _localizedValues;

  Future<void> load() async {
    String jsonStringValues =
    await rootBundle.loadString('i18n/${locale.toString()}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedValues[key];
  }

// static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<MyLocalizations> delegate =
  _MyLocalizationsDelegate();
}

class _MyLocalizationsDelegate
    extends LocalizationsDelegate<MyLocalizations> {
  const _MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalizations> load(Locale locale) async {
    MyLocalizations localization = new MyLocalizations(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<MyLocalizations> old) => false;
}