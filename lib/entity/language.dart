import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgp_flutter/localizations/my_localizations.dart';

class Language {
  Language(this.code, this.name, this.locale);

  String code;
  String name;
  Locale locale;

}