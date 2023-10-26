class WeatherData {
  final double latitude;
  final double longitude;
  final String timezone;
  final HourlyData hourlyData;
  final DailyData dailyData;
  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.hourlyData,
    required this.dailyData,
  });
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
      hourlyData: HourlyData.fromJson(json['hourly']),
      dailyData: DailyData.fromJson(json['daily']),
    );
  }
}

class HourlyData {
  final List<String> time;
  final List<double> temperature2m;
  final List<int> weatherCode;
  final List<double> windSpeed10m;
  final List<int> windDirection10m;
  HourlyData({
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
    required this.windSpeed10m,
    required this.windDirection10m,
  });
  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      time: List<String>.from(json['time']),
      temperature2m: List<double>.from(json['temperature_2m']),
      weatherCode: List<int>.from(json['weathercode']),
      windSpeed10m: List<double>.from(json['windspeed_10m']),
      windDirection10m: List<int>.from(json['winddirection_10m']),
    );
  }
}

class DailyData {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<double> apparentTemperatureMax;
  final List<double> apparentTemperatureMin;
  final List<double> windSpeed10mMax;
  DailyData({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.apparentTemperatureMax,
    required this.apparentTemperatureMin,
    required this.windSpeed10mMax,
  });
  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      time: List<String>.from(json['time']),
      weatherCode: List<int>.from(json['weathercode']),
      temperature2mMax: List<double>.from(json['temperature_2m_max']),
      temperature2mMin: List<double>.from(json['temperature_2m_min']),
      apparentTemperatureMax:
          List<double>.from(json['apparent_temperature_max']),
      apparentTemperatureMin:
          List<double>.from(json['apparent_temperature_min']),
      windSpeed10mMax: List<double>.from(json['windspeed_10m_max']),
    );
  }
}
