import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/my_city.dart';
import 'package:weather/models/my_colors.dart';
import 'package:weather/providers/api_provider.dart';
import 'package:weather/providers/theme_provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController txtController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    MyColors theme = context.watch<ThemeProvider>().theme;
    ApiProvider provider = Provider.of<ApiProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        leadingWidth: 0,
        leading: SizedBox(),
        actions: [
          TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.only(left: 0, right: 8)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: theme.textColor),
              ))
        ],
        title: appBarSearchWidget(provider, theme),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ApiProvider>(
            builder: (context, value, child) {
              List<MyCity> results = value.searchResult;
              bool isSearching = value.isSearching;
              if (results.isEmpty) {
                return Center(
                    child: Text(
                  'No Result!',
                  style: TextStyle(color: theme.textColor),
                ));
              }
              return isSearching
                  ? const Center(child: Text('Searching ...'))
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        if (results.isEmpty) {
                          return Text('no reuslts');
                        } else {
                          return searchCityWidget(results, index, value, theme);
                        }
                      },
                    );
            },
          ),
        ),
      ),
    );
  }

  Container appBarSearchWidget(ApiProvider provider, MyColors theme) {
    return Container(
      height: kTextTabBarHeight,
      decoration: BoxDecoration(
        color: theme.searchBarColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Icon(
                Icons.search,
                color: theme.searchBarContent,
              ),
            ),
            Expanded(
              flex: 5,
              child: TextField(
                controller: txtController,
                decoration: InputDecoration(
                    hintText: 'Country Name',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: theme.searchBarContent,
                    )),
                onChanged: (value) {
                  provider.citiesSearchResult(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container searchCityWidget(
      List<MyCity> results, int index, ApiProvider value, MyColors theme) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  results[index].city.name,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 20, color: theme.textColor),
                ),
                Text(
                  '${results[index].country.name}  ${results[index].country.flag}',
                  style: TextStyle(
                      color: theme.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                value.addCity(results[index].city);
              },
              icon: CircleAvatar(
                backgroundColor: theme.searchBarColor,
                child: Icon(
                  Icons.add,
                  color: theme.iconColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
