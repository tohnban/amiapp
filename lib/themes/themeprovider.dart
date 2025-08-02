import 'package:flutter/material.dart';

import 'darkmode.dart';
import 'lightmode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode; // Inicializa com o tema claro

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
