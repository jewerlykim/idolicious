import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarProvider with ChangeNotifier {
  StarProvider() {
    _loadStarPreference();
  }

  String _star = 'none'; // default star

  String get star => _star;

  set star(String newStar) {
    _star = newStar;
    notifyListeners();
    _saveStarPreference();
  }

  _loadStarPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _star = prefs.getString('star') ?? 'none';
    notifyListeners();
  }

  _saveStarPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('star', _star);
  }
}
