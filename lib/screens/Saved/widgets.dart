import 'package:flutter/material.dart';
import 'package:weather/models/city_weather.dart';
import 'package:weather/models/my_colors.dart';
import 'package:weather/providers/api_provider.dart';

Widget savedCityWidget(
    CityWeather myCity, ApiProvider value, BuildContext context,MyColors theme) {
  return Dismissible(
    key: Key(myCity.city.name),
    onDismissed: (_) {
      value.removeCity(myCity.city);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: theme.backgroundColor,
          content: Text(
        'Deleted',
        style: TextStyle(
          color: theme.textColor,
        ),
      )));
    },
    background: const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.remove_circle_outline,
          size: 30,
          color: Colors.red,
        )
      ],
    ),
    direction: DismissDirection.endToStart,
    child: Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: myCity.weather.getCurrentHourData().gradientColors),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myCity.city.name,
                  overflow: TextOverflow.ellipsis,
                  style:  TextStyle(fontSize: 25,color: theme.textColor),
                ),
                Text(
                  '${myCity.weather.getCurrentDayWeather().maxTemperature.floor()}°/${myCity.weather.getCurrentDayWeather().minTemperature.floor()}°',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.textColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Text(
                  '${myCity.weather.getCurrentHourData().temperature.floor()}°',
                  style:  TextStyle(
                    fontSize: 20,
                    color: theme.textColor,
                  ),
                ),
              ),
              Expanded(
                  child: Image.asset(
                      myCity.weather.getCurrentDayWeather().iconUrl!)),
            ],
          )),
        ],
      ),
    ),
  );
}
