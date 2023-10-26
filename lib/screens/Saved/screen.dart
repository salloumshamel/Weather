import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/city_weather.dart';
import 'package:weather/models/my_colors.dart';
import 'package:weather/providers/api_provider.dart';
import 'package:weather/providers/theme_provider.dart';
import 'package:weather/screens/Saved/widgets.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    MyColors theme = context.watch<ThemeProvider>().theme;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.iconColor),
        forceMaterialTransparency: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<ApiProvider>(context, listen: false).getSavedRecall();
        },
        backgroundColor: theme.backgroundColor,
        color: theme.textColor,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cities Management',
                  style: TextStyle(fontSize: 25, color: theme.textColor),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.searchBarColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: theme.searchBarContent,
                      ),
                      title: Text(
                        'Search',
                        style: TextStyle(
                          color: theme.searchBarContent,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/add');
                      },
                    ),
                  ),
                ),
                Consumer<ApiProvider>(
                  builder: (context, value, child) {
                    List<CityWeather> results = value.savedCities;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          CityWeather myCity = results[index];
                          return savedCityWidget(myCity, value, context, theme);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
