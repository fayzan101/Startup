import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeService extends ChangeNotifier {
  ThemeService._internal();
  static final ThemeService instance = ThemeService._internal();

  Color _primaryColor =const Color(0xFFDEB887);

  Brightness _brightness = Brightness.light;

  Color get primaryColor => _primaryColor;
  Brightness get brightness => _brightness;

  void setPrimaryColor(Color color) {
    if (color == _primaryColor) return;
    _primaryColor = color;
    notifyListeners();
  }

  void setBrightness(Brightness brightness) {
    if (brightness == _brightness) return;
    _brightness = brightness;
    notifyListeners();
  }

  ThemeData get themeData {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: _brightness,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Colors.white24,
        labelTextStyle: MaterialStatePropertyAll(
          TextStyle(color: Colors.white),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: _primaryColor),
          foregroundColor: _primaryColor,
        ),
      ),
    );
  }

  SystemUiOverlayStyle systemUiOverlayForPrimary({bool lightIcons = true}) {
    return SystemUiOverlayStyle(
      statusBarColor: _primaryColor,
      statusBarIconBrightness: lightIcons ? Brightness.light : Brightness.dark,
      statusBarBrightness: lightIcons ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }
}


