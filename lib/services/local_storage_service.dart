import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future setLang(String lang) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("lang", lang);
  }

  Future setData(String key, String data) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(key, data);
  }

  Future<String?> getData(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  Future<bool> clear({String? key}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (key == null) {
      _prefs.clear();
    } else {
      _prefs.remove(key);
    }
    return true;
  }

  Future<bool> setUser(model) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var json = jsonEncode(model.toJson());
    _prefs.setString("User", json);
    return true;
  }

  Future setNightMode(bool mode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("mode", mode);
  }

  Future<bool?> get getThemeMode async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("mode");
  }

  Future<dynamic>? get getUser async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey("User")) {
      return null;
    }
    var user = jsonDecode(_prefs.getString("User")!);
    return user;
  }

  Future<String?> getLang() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey("lang")) return _prefs.getString("lang");
    return null;
  }
}
