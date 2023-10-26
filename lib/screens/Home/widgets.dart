import 'package:day_night_themed_switch/day_night_themed_switch.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/my_colors.dart';
import 'package:weather/models/weather/weather.dart';
import 'package:weather/providers/api_provider.dart';
import 'package:weather/providers/theme_provider.dart';

Drawer drawerWidget(MyColors theme, BuildContext context) {
  return Drawer(
    backgroundColor: theme.backgroundColor,
    width: MediaQuery.of(context).size.width * 0.75,
    child: SafeArea(
        child: ListView(
      padding: const EdgeInsets.only(right: 8),
      children: [
        ListTile(
          leading: Icon(
            Icons.settings,
            color: theme.iconColor,
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              color: theme.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.delete_forever, color: theme.iconColor),
          onTap: () {
            Provider.of<ApiProvider>(context, listen: false).resetSettings();
          },
          title: Text(
            'clear all cities',
            style: TextStyle(color: theme.textColor, fontSize: 15),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ListTile(
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setIsAutoMode();
                },
                leading: Icon(
                  Icons.auto_awesome,
                  color: theme.iconColor,
                ),
                title: context.watch<ThemeProvider>().isAuto
                    ? Text(
                        'Disable Auto Mode',
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 15,
                        ),
                      )
                    : Text(
                        'Enable Auto Mode',
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 15,
                        ),
                      ),
              ),
            ),
          ],
        ),
        !context.watch<ThemeProvider>().isAuto
            ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      leading: Icon(Icons.color_lens, color: theme.iconColor),
                      title: Text(
                        'Color Mode',
                        style: TextStyle(color: theme.textColor, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DayNightSwitch(
                      value: context.watch<ThemeProvider>().isDarkMode,
                      onChanged: (value) {
                        value != value;
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeMode();
                      },
                    ),
                  )
                ],
              )
            : const SizedBox()
      ],
    )),
  );
}

Widget generalWeatherInformation(
    ApiProvider value, Hourly weather, DateTime time, MyColors theme) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM').format(DateTime.parse(weather.time)),
                style: TextStyle(
                  color: theme.textColor,
                  fontSize: 22,
                ),
              ),
              Wrap(
                  spacing: 5,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Text(
                      weather.temperature.floor().toString(),
                      style: TextStyle(
                        color: theme.textColor,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      'C°',
                      style: TextStyle(
                        color: theme.textColor,
                        fontSize: 30,
                      ),
                    ),
                  ]),
              Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 10,
                children: [
                  Text(
                    DateFormat('EEE').format(DateTime.parse(weather.time)),
                    style: TextStyle(
                      color: theme.textColor,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    weather.weatherDescription.toString(),
                    style: TextStyle(
                      color: theme.textColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Image.asset(weather.iconUrl!),
        ),
      ],
    ),
  );
}

Widget dailyListView(
    BuildContext context, List<Daily> dailyData, MyColors theme) {
  return Column(
    children: [
      Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Next 7 Days',
                style: TextStyle(
                  color: theme.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              dailyDataWidget(dailyData[0], theme),
              const SizedBox(
                height: 5,
              ),
              dailyDataWidget(dailyData[1], theme),
              const SizedBox(
                height: 5,
              ),
              dailyDataWidget(dailyData[2], theme),
              const SizedBox(
                height: 5,
              ),
              dailyDataWidget(dailyData[3], theme),
              const SizedBox(
                height: 5,
              ),
              dailyDataWidget(dailyData[4], theme),
              const SizedBox(
                height: 5,
              ),
              dailyDataWidget(dailyData[5], theme),
              const SizedBox(
                height: 5,
              ),
              dailyDataWidget(dailyData[6], theme),
            ],
          )),
    ],
  );
}

Widget dailyDataWidget(Daily data, MyColors theme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Wrap(
        spacing: 10,
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset(
            data.iconUrl!,
            width: 50,
            height: 50,
          ),
          Text(
            DateFormat('EEEE').format(
              DateTime.parse(data.time),
            ),
            style: TextStyle(
              color: theme.textColor,
            ),
          ),
        ],
      ),
      Text(
        '${data.maxTemperature.floor()}C°/${data.minTemperature.floor()}C°',
        style: TextStyle(
          color: theme.textColor,
        ),
      )
    ],
  );
}

SizedBox hourlyListView(
    BuildContext context, List<Hourly> lastHours, MyColors theme) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.15,
    child: ListView.builder(
        itemCount: lastHours.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Image.asset(
                  lastHours[index].iconUrl!,
                )),
                Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text(
                        lastHours[index].temperature.toString(),
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'C°',
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 10,
                        ),
                      ),
                    ]),
                Text(
                  DateFormat('h:mm a')
                      .format(DateTime.parse(lastHours[index].time)),
                  style: TextStyle(
                    color: theme.textColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        }),
  );
}
