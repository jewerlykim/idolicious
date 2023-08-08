import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceProvider with ChangeNotifier {
  PlaceProvider() {
    _loadPlacePreference();
  }

  String _place = 'none'; // default place

  String get place => _place;

  set place(String newPlace) {
    _place = newPlace;
    notifyListeners();
    _savePlacePreference();
  }

  _loadPlacePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _place = prefs.getString('place') ?? 'none';
    notifyListeners();
  }

  _savePlacePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('place', _place);
  }
}
