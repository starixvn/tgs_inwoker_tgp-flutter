import 'package:flutter/material.dart';
import 'package:tgp_flutter/localizations/language_provider.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>{
  getTranslatedText(String key) => LanguageProvider().getTranslated(context, key);
}