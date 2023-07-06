import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    // gredient scaffold background'
    scaffoldBackgroundColor: const Color(0xFF212121),
    primaryColor: Color.fromARGB(255, 32, 10, 10),
    secondaryHeaderColor: Color.fromARGB(255, 32, 10, 10),
    colorScheme:  ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    secondaryHeaderColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme:  ColorScheme.light(),
  );
}
