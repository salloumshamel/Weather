import 'package:flutter/widgets.dart';
import 'package:weather/models/weather/weather_response.dart';
import 'package:weather/style/weather_style.dart';

class Weather {
  final List<Daily> daily = [];
  WeatherData weather;
  bool isDay;
  Weather({required this.weather, required this.isDay}) {
    int from = 0;
    int to = 24;
    int j = 0;
    DailyData dailyData = weather.dailyData;
    HourlyData hourlyData = weather.hourlyData;
    for (int i = 0; i < dailyData.time.length; i++) {
      List<Hourly> hourlyList = [];
      for (j = from; j < to; j++) {
        Hourly hourly = Hourly(
            time: hourlyData.time[j],
            temperature: hourlyData.temperature2m[j],
            windSpeed: hourlyData.windSpeed10m[j],
            weatherCode: hourlyData.weatherCode[j]);
        hourlyList.add(hourly);
      }

      daily.add(Daily(
          isDay: isDay,
          time: dailyData.time[i],
          maxTemperature: dailyData.temperature2mMax[i],
          minTemperature: dailyData.temperature2mMin[i],
          maxApparentTemperature: dailyData.apparentTemperatureMax[i],
          minApparentTemperature: dailyData.apparentTemperatureMin[i],
          maxWindSpeed: dailyData.windSpeed10mMax[i],
          weatherCode: dailyData.weatherCode[i],
          hourly: hourlyList));
      to += 24;
      from += 24;
    }
  }

  Daily getCurrentDayWeather() {
    return daily.first;
  }

  //TODO
  Hourly getCurrentHourData() {
    final DateTime now = DateTime.now();
    final String currentHour =
        '${now.year}-${_formatTwoDigits(now.month)}-${_formatTwoDigits(now.day)}T${_formatTwoDigits(now.hour)}:00';
    final Daily currentDay = daily.first;
    final Hourly currentHourData = currentDay.hourly.firstWhere(
      (hourly) => hourly.time == currentHour,
    );
    return currentHourData;
  }

  List<Hourly> getTheNextHoursOfCurrentDate() {
    List<Hourly> data = [];
    final DateTime now = DateTime.now();
    final Daily currentDay = daily.first;
    for (Hourly hourly in currentDay.hourly) {
      DateTime date = DateTime.parse(hourly.time);
      if (date.hour >= now.hour) {
        data.add(hourly);
      }
    }
    return data;
  }

  List<Hourly> getTheNext24HourData() {
    List<Hourly> data = [];
    final DateTime now = DateTime.now();
    final HourlyData hourlyData = weather.hourlyData;
    int from = hourlyData.time
        .indexWhere((element) => DateTime.parse(element).hour == now.hour);
    int to = from + 24;
    for (var i = from; i < to; i++) {
      data.add(Hourly(
          windSpeed: hourlyData.windSpeed10m[i],
          temperature: hourlyData.temperature2m[i],
          weatherCode: hourlyData.weatherCode[i],
          time: hourlyData.time[i]));
    }
    return data;
  }

  String _formatTwoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }
}

class Daily {
  final String time;
  final double maxTemperature;
  final double minTemperature;
  final double maxApparentTemperature;
  final double minApparentTemperature;
  final double maxWindSpeed;
  final int weatherCode;
  final bool isDay;
  final List<Hourly> hourly;

  String? iconUrl;
  String? weatherDescription;
  List<Color> gradientColors = [];
  Daily({
    required this.time,
    required this.maxTemperature,
    required this.maxWindSpeed,
    required this.minTemperature,
    required this.maxApparentTemperature,
    required this.minApparentTemperature,
    required this.weatherCode,
    required this.hourly,
    required this.isDay,
  }) {
    weatherDescription = WeatherStyle.getWeatherDescription(weatherCode);
    iconUrl = WeatherStyle.getWeatherIcon(weatherCode, isDay);
    gradientColors = WeatherStyle.getWeatherColor(weatherCode, isDay);
  }
}

class Hourly {
  final String time;
  final double windSpeed;
  final double temperature;
  final int weatherCode;
  List<Color> gradientColors = [];
  String? iconUrl;
  String? weatherDescription;

  Hourly({
    required this.windSpeed,
    required this.temperature,
    required this.weatherCode,
    required this.time,
  }) {
    weatherDescription = WeatherStyle.getWeatherDescription(weatherCode);
    iconUrl = WeatherStyle.getWeatherIcon(weatherCode, _isDay());
    gradientColors = WeatherStyle.getWeatherColor(weatherCode, _isDay());
  }

  bool _isDay() {
    if (DateTime.parse(time).hour >= 6 && DateTime.parse(time).hour <= 18) {
      return true;
    }
    return false;
  }
}
