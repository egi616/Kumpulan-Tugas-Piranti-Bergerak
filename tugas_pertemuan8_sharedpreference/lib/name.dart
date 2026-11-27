import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameProvider extends ChangeNotifier{

  static const _nameKey = 'nameKey';

  String _name = '';
  String get name => _name;

  NameProvider(){
    _loadName();
  }

  void _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_nameKey) ?? '';
    notifyListeners();
  }

  void saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    _name = name.isEmpty?'' : name;
    prefs.setString(_nameKey, _name);
    notifyListeners();
  }
}