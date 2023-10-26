import 'package:flutter/material.dart';

class MyColors {
  Color iconColor = Colors.black;
  Color textColor = Colors.black;
  Color backgroundColor = const Color(0xff202123);
  Color searchBarColor = Colors.grey[350]!;
  Color searchBarContent = Colors.grey[500]!;
  List<Color> homePageGradient = [
    Colors.lightBlue,
    Colors.blue,
  ];

  MyColors(
      {required this.iconColor,
      required this.homePageGradient,
      required this.backgroundColor,
      required this.searchBarColor,
      required this.searchBarContent,
      required this.textColor});
}
