import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/my_colors.dart';
import 'package:weather/models/weather/weather.dart';
import 'package:weather/providers/api_provider.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/screens/Home/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    MyColors theme = context.watch<ThemeProvider>().theme;
    final DateTime time = DateTime.now();
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      endDrawer: drawerWidget(theme, context),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/saved');
          },
          icon: Icon(
            Icons.add,
            color: theme.iconColor,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: theme.iconColor,
                size: 30,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<ApiProvider>(context, listen: false).apiRecall();
        },
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        edgeOffset: 20,
        backgroundColor: theme.backgroundColor,
        color: theme.textColor,
        child: Consumer<ApiProvider>(
          builder: (context, value, child) {
            final Hourly weather =
                value.myLocationWeather!.getCurrentHourData();
            final List<Daily> dailyData = value.myLocationWeather!.daily;
            final List<Hourly> lastHours =
                value.myLocationWeather!.getTheNext24HourData();
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: theme.homePageGradient,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: kToolbarHeight + 10),
                      child: Column(
                        children: [
                          generalWeatherInformation(
                              value, weather, time, theme),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                windSpeedAndDescriptionWidget(
                                  weather,
                                  theme,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Next 24 Hours',
                                  style: TextStyle(
                                    color: theme.textColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                hourlyListView(context, lastHours, theme),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          dailyListView(context, dailyData, theme),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget windSpeedAndDescriptionWidget(Hourly weather, MyColors theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wind Speed',
          style: TextStyle(
            color: theme.textColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Image.asset(
              'images/icons/wind_speed.png',
              height: 75,
              width: 75,
            ),
            Text(
              '${weather.windSpeed} km/h',
              style: TextStyle(color: theme.textColor, fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }
}

// Widget weatherDescriptionWidget(Hourly weather, MyColors theme) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Image.asset(
//         weather.iconUrl!,
//         height: 75,
//         width: 75,
//       ),
//       Column(
//         children: [
//           Text(
//             'weather description',
//             style: TextStyle(color: theme.textColor, fontSize: 15),
//           ),
//           Text(
//             '${weather.weatherDescription}',
//             style: TextStyle(color: theme.textColor, fontSize: 15),
//           ),
//         ],
//       ),
//     ],
//   );
// }
