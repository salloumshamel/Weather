import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? service;
  List<String> countries = [];
  List<String> cities = [];
  bool isAutoMode = false;
  bool isDarkMode = false;

  Future<void> getCities() async {
    service = await SharedPreferences.getInstance();
    try {
      cities.addAll(service!.getStringList('cities')!);
      countries.addAll(service!.getStringList('countries')!);

      log('your saved cities : $cities countries code $countries');
    } catch (error) {
      log('some thing went wrong (getCities) $error');
    }
  }

  Future<void> getSettings() async {
    try {
      service = await SharedPreferences.getInstance();
      isAutoMode = service!.getBool('isAuto')!;
      isDarkMode = service!.getBool('isDark')!;
      log('isAuto $isAutoMode , isDark $isDarkMode');
    } catch (error) {
      log('something went wrong (getSettings) $error');
    }
  }

  Future<void> setIsAutoMode(bool isAuto) async {
    try {
      await service?.setBool('isAuto', isAuto);
      isAutoMode = isAuto;
    } catch (error) {
      log('something went wrong (setIsAutoMode) $error');
    }
  }

  Future<void> setIsDarkMode(bool isDark) async {
    try {
      await service?.setBool('isDark', isDark);
      isDarkMode = isDark;
    } catch (error) {
      log('something went wrong (setISDarkMode) $error');
    }
  }

  Future<void> addCity(
      {required String cityName, required String countryCode}) async {
    try {
      cities.add(cityName);
      countries.add(countryCode);
      await service!.setStringList('cities', cities);
      await service!.setStringList('countries', countries);
      log('$cityName / $countryCode added Successfully');
    } catch (e) {
      log('something went wrong (addCity) $e');
    }
  }

  Future<void> removeCity(
      {required String cityName, required String countryCode}) async {
    try {
      cities.remove(cityName);
      countries.remove(countryCode);
      await service!.setStringList('cities', cities);
      await service!.setStringList('countries', countries);
      log('$cityName / $countryCode removed Successfully');
    } catch (e) {
      log('something went wrong (removeCity) $e');
    }
  }

  Future<void> resetSettings() async {
    try {
      await service!.clear();
    } catch (e) {
      log('something went wrong (resetCities) $e');
    }
  }
}
