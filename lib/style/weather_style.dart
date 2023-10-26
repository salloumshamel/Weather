import 'package:flutter/widgets.dart';

class WeatherStyle {
  static String getWeatherIcon(int code, bool isDay) {
    switch (code) {
      case 0:
        return isDay ? 'images/icons/sun.png' : 'images/icons/moon.png';
      case 1:
      case 2:
        return isDay
            ? 'images/icons/cloud_sun.png'
            : 'images/icons/cloud_moon.png';
      case 3:
      case 45:
      case 48:
        return 'images/icons/cloud.png';
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return 'images/icons/cold.png';
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
        return 'images/icons/rain.png';
      case 66:
      case 67:
        return 'images/icons/snow_rain.png';
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return 'images/icons/snow.png';
      case 95:
      case 96:
      case 99:
        return 'images/icons/storm.png';
      default:
        return isDay
            ? 'images/icons/cloud_sun.png'
            : 'images/icons/cloud_moon.png';
    }
  }

  static List<Color> getWeatherColor(int code, bool isDay) {
    switch (code) {
      case 0:
        return isDay
            ? [Color(0xFFFFF17A).withOpacity(0.5), const Color(0xFFFFD700)]
            : [
                const Color.fromARGB(255, 58, 58, 114).withOpacity(0.5),
                const Color.fromARGB(255, 97, 97, 144)
              ]; // Clear Night: Dark Blue to Dark Gray
      case 1:
      case 2:
        return isDay
            ? [
                const Color(0xFFC0C0C0).withOpacity(0.5),
                const Color(0xFFD3D3D3)
              ] // Cloudy Day: Silver to Light Gray
            : [
                const Color(0xFF333344).withOpacity(0.5),
                const Color(0xFF555566)
              ]; // Cloudy Night: Dark Gray to Gray
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
      case 66:
      case 67:
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return isDay
            ? [
                const Color(0xFF0000FF).withOpacity(0.5),
                const Color(0xFF6666FF),
              ] // Rainy Day: Blue to Light Blue
            : [
                const Color.fromARGB(255, 0, 0, 131).withOpacity(0.5),
                const Color.fromARGB(255, 70, 70, 159),
              ]; // Rainy Night: Dark Blue to Dark Gray
      case 95:
      case 96:
      case 99:
        return isDay
            ? [
                const Color(0xFF808080).withOpacity(0.5),
                const Color(0xFFD3D3D3)
              ]
            : [
                const Color(0xFF000000).withOpacity(0.5),
                const Color(0xFF808080)
              ];
      default:
        return isDay
            ? [
                const Color(0xFFD3D3D3).withOpacity(0.5),
                const Color(0xFFE0E0E0)
              ] // Default: Light Gray to Lighter Gray
            : [
                const Color(0xFF333344).withOpacity(0.5),
                const Color(0xFF555566)
              ]; // Default Night: Dark Gray to Gray
    }
  }

  static String getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Mainly clear';
      case 2:
        return 'Partly cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Fog and depositing rime fog';
      case 51:
        return 'Drizzle: Light intensity';
      case 53:
        return 'Drizzle: Moderate intensity';
      case 55:
        return 'Drizzle: Dense intensity';
      case 56:
        return 'Freezing Drizzle: Light intensity';
      case 57:
        return 'Freezing Drizzle: Dense intensity';
      case 61:
        return 'Rain: Slight intensity';
      case 63:
        return 'Rain: Moderate intensity';
      case 65:
        return 'Rain: Heavy intensity';
      case 66:
        return 'Freezing Rain: Light intensity';
      case 67:
        return 'Freezing Rain: Heavy intensity';
      case 71:
        return 'Snowfall: Slight intensity';
      case 73:
        return 'Snowfall: Moderate intensity';
      case 75:
        return 'Snowfall: Heavy intensity';
      case 77:
        return 'Snow grains';
      case 80:
        return 'Rain showers: Slight intensity';
      case 81:
        return 'Rain showers: Moderate intensity';
      case 82:
        return 'Rain showers: Violent intensity';
      case 85:
        return 'Snow showers: Slight intensity';
      case 86:
        return 'Snow showers: Heavy intensity';
      case 95:
        return 'Thunderstorm: Slight';
      case 96:
        return 'Thunderstorm with slight hail';
      case 99:
        return 'Thunderstorm with heavy hail';
      default:
        return 'Unknown weather code';
    }
  }
}
