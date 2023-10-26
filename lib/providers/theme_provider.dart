import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather/models/my_colors.dart';
import 'package:weather/services/shared_services.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferencesService shared = SharedPreferencesService();
  bool isDarkMode = false;
  bool isAuto = false;

  MyColors theme = MyColors(
      homePageGradient: [
        Colors.lightBlue, // You can adjust this shade of blue
        Colors.blue, // You can adjust this shade of blue
      ],
      iconColor: Colors.black,
      backgroundColor: Colors.white,
      searchBarColor: Colors.grey[400]!,
      searchBarContent: Colors.grey[500]!,
      textColor: Colors.black);

  Future<void> initialize() async {
    await shared.getSettings();
    isAuto = shared.isAutoMode;
    log('isAuto value is $isAuto');
    if (isAuto) {
      _isAutoBloc();
    } else {
      isDarkMode = shared.isDarkMode;
      log('isDarkMode value : $isDarkMode');
      if (isDarkMode) {
        _turnDarkMode();
      } else {
        _turnLightMode();
      }
    }
    notifyListeners();
  }

  Future<void> setIsAutoMode() async {
    await shared.setIsAutoMode(!isAuto);
    isAuto = !isAuto;
    if (isAuto) _isAutoBloc();
    notifyListeners();
  }

  Future<void> changeMode() async {
    await shared.setIsDarkMode(!isDarkMode);
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      _turnDarkMode();
    } else {
      _turnLightMode();
    }
    notifyListeners();
  }

  void _turnDarkMode() {
    theme = MyColors(
        homePageGradient: [Colors.indigo, Colors.purple, Colors.black],
        iconColor: Colors.white,
        backgroundColor: const Color(0xff202123),
        searchBarColor: Colors.grey[400]!,
        searchBarContent: Colors.grey[700]!,
        textColor: Colors.white);
  }

  void _turnLightMode() {
    theme = MyColors(
        homePageGradient: [
          Colors.lightBlue,
          const Color.fromARGB(255, 15, 147, 255),
        ],
        iconColor: Colors.black,
        backgroundColor: Colors.white,
        searchBarColor: Colors.grey[500]!,
        searchBarContent: Colors.grey[800]!,
        textColor: Color.fromARGB(255, 36, 36, 36));
  }

  bool _setIsDay() {
    DateTime now = DateTime.now();
    return (now.hour > 7 && now.hour < 18);
  }

  void _isAutoBloc() {
    if (_setIsDay()) {
      _turnLightMode();
    } else {
      _turnDarkMode();
    }
  }
}
