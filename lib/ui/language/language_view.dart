import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_api/entity/language.dart';
import 'package:shared_api/extension/screen_apis.dart';
import 'package:shared_api/localizations/language_provider.dart';
import 'package:tgp_flutter/main.dart';
import 'package:tgp_flutter/provider/provider_widget.dart';
import 'package:tgp_flutter/ui/base_state.dart';
import 'package:tgp_flutter/src/gradient_decoration.dart';
import 'package:tgp_flutter/ui/language/language_item.dart';
import 'package:tgp_flutter/ui/language/login_view_model.dart';

class LanguageView extends StatefulWidget {
  @override
  _LanguageViewState createState() => _LanguageViewState();
}

class _LanguageViewState extends BaseState<LanguageView> {
  var isEditing = false, isSelected = false;
  var list = LanguageProvider().list;
  var _vm = LanguageViewModel();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var deviceLanguage = list.singleWhere((e) => e.locale == Localizations.localeOf(context));
    return ProviderWidget<LanguageViewModel>(
        model: _vm,
        builder: (ctx, vm, _) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: gradientDecoration,
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  getTranslatedText("language"),
                  style: TextStyle(fontSize: 16.auto),
                ),
              ),
              body: ListView(
                children: List.generate(
                    list.length,
                    (index) => Container(
                          child: InkWell(
                            onTap: () => _changeLanguage(list[index]),
                            child: LanguageItem(
                              imagePath: list[index].imageRes,
                              text: list[index].name,
                              isSelected: deviceLanguage == list[index],
                            ),
                          ),
                        )),
              ));
        });
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await LanguageProvider().setLocale(language);
    MyApp.setLocale(context, _locale);
    await _vm.getApiError();
  }
}
