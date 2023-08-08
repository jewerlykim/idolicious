import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  LanguageProvider() {
    _loadLanguagePreference();
  }

  String _language = 'English'; // default language

  String get language => _language;

  set language(String newLanguage) {
    _language = newLanguage;
    notifyListeners();
    _saveLanguagePreference();
  }

  _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? 'English';
    notifyListeners();
  }

  _saveLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _language);
  }
}
