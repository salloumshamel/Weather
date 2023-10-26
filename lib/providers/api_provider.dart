import 'dart:async';
import 'dart:developer';
import 'package:country_state_city/country_state_city.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/apis/http_requests.dart';
import 'package:weather/models/city_weather.dart';
import 'package:weather/models/my_city.dart';
import 'package:weather/models/weather/weather.dart';
import 'package:weather/models/weather/weather_response.dart';
import 'package:weather/services/location_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/services/shared_services.dart';

class ApiProvider extends ChangeNotifier {
  //Services
  final LocationServices _locationServices = LocationServices();
  final SharedPreferencesService _sharedServices = SharedPreferencesService();
  final API _api = API();
  //static
  List<City> allCities = [];
  Position? _currentPosition;
  Timer? apiTimer;
  Timer? savedTimer;
  //boolean
  bool isSearching = false;
  bool isLoading = true;
  //variables
  String locationName = 'unknown';
  List<CityWeather> savedCities = [];
  List<MyCity> searchResult = [];
  Weather? myLocationWeather;

  Future<void> initialize() async {
    await _sharedServices.getCities();
    _currentPosition = await _locationServices.initialize();
    myLocationWeather = await getCurrentWeather();
    allCities = await getAllCities();
    await getSaveCities();
    _isLoadingChange();
  }

  Future<void> apiRecall() async {
    myLocationWeather = await getCurrentWeather();
    notifyListeners();
  }

  Future<void> getSavedRecall() async {
    await getSaveCities();
    notifyListeners();
  }

  Future<Weather> getCurrentWeather() async {
    WeatherData weather = await _api.getWeather(
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
    ) as WeatherData;
    log('Weather is Here');
    return Weather(
      weather: weather,
      isDay: _setIsDay(),
    );
  }

  Future<void> getSaveCities() async {
    savedCities.clear();
    List<String> citiesName = [];
    List<String> countriesCode = [];
    citiesName.addAll(_sharedServices.cities);
    countriesCode.addAll(_sharedServices.countries);
    for (int i = 0; i < citiesName.length; i++) {
      try {
        City city = allCities.firstWhere((element) =>
            (element.name == citiesName[i] &&
                element.countryCode == countriesCode[i]));
        try {
          final WeatherData weather = await _api.getWeather(
              latitude: double.parse(city.latitude!),
              longitude: double.parse(city.longitude!)) as WeatherData;
          savedCities.add(CityWeather(
              city: city,
              weather: Weather(weather: weather, isDay: _setIsDay())));
        } catch (e) {
          log('something went wrong (getSavedCities _ getWeather) $e');
        }
      } catch (e) {
        log('something went wrong (getSaveCities _ findCity) $e');
      }
    }
  }

  Future<void> addCity(City city) async {
    try {
      await _sharedServices
          .addCity(cityName: city.name, countryCode: city.countryCode)
          .then((_) async {
        WeatherData weather = await _api.getWeather(
            latitude: double.parse(city.latitude!),
            longitude: double.parse(city.longitude!)) as WeatherData;
        savedCities.add(CityWeather(
            city: city,
            weather: Weather(weather: weather, isDay: _setIsDay())));
        notifyListeners();
      });
    } catch (e) {
      log('something went wrong (addCity) $e');
    }
  }

  Future<void> removeCity(City city) async {
    try {
      await _sharedServices
          .removeCity(cityName: city.name, countryCode: city.countryCode)
          .then((_) =>
              savedCities.removeWhere((element) => element.city == city));
      notifyListeners();
    } catch (e) {
      log('something went wrong (remove city) $e');
    }
  }

  Future<void> resetSettings() async {
    try {
      await _sharedServices.resetSettings().then((_) => savedCities.clear());
      notifyListeners();
    } catch (e) {
      log('something went wrong (resetSettings) $e');
    }
  }

  Future<void> citiesSearchResult(String city) async {
    int counter = 0;
    if (city.length < 3) return;
    _isSearchingChange();
    try {
      searchResult.clear();
      for (City element in allCities) {
        if (element.name.toLowerCase().startsWith(city.toLowerCase())) {
          Country? country = await getCountryFromCode(element.countryCode);
          searchResult.add(MyCity(city: element, country: country!));
          counter++;
          if (counter == 10) break;
        }
      }
    } catch (e) {
      log('something went wrong (citiesSearchResult) $e');
    }
    _isSearchingChange();
  }

  Future<void> getAddressName() async {
    try {
      List<Placemark> placeMarks =
          await GeocodingPlatform.instance.placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      Placemark placeMark = placeMarks.first;
      locationName = '${placeMark.country} ${placeMark.subLocality}';
    } catch (e) {
      log('something went wrong $e');
    }
  }

  void _isLoadingChange() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void _isSearchingChange() {
    isSearching = !isSearching;
    notifyListeners();
  }

  bool _setIsDay() {
    DateTime now = DateTime.now();
    return (now.hour > 6 && now.hour < 18);
  }
}
