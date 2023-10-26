import 'dart:developer';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/weather/weather_response.dart';

class API {
  Future<dynamic> getWeather(
      {required double latitude, required double longitude}) async {
    try {
      final url = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,weathercode,windspeed_10m,winddirection_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,windspeed_10m_max&timezone=auto');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // log('your response here ${response.body}');
        final data = jsonDecode(response.body);
        return WeatherData.fromJson(data);
      } else {
        log('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Something went wrong: $e');
      return null;
    }
  }
}
