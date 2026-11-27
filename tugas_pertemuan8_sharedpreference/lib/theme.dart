import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  // =>kependekan return
  ThemeMode get themeMode => _themeMode; 
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  static const _themeKey = 'theme_key';

  ThemeProvider(){
    _loadTheme();
  }

  //async agar ketika flutter mengambil data dan masih false maka ui nya akan masih tampl
  void _loadTheme () async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    
    //itenary
    _themeMode = isDark? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); //untuk memberitahu perubahan 
  }

  //async ada waktu tunggunnya
  void toggleTheme(bool isOn) async{
    _themeMode = isOn? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isOn);
  }

}